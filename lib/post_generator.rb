# Generate a post and if necessary related articles
class PostGenerator
  # +post+ argument key
  KEY_POST = :post
  # +article+ argument key
  KEY_ARTICLE = :article
  # +delete+ argument key
  KEY_HELP = :help
  # +date+ argument key
  KEY_DATE = :date
  # +dryrun+ argument key
  KEY_DRYRUN = :dryrun
  # Argument keys are identified with double dashes
  KEY_DETECTOR = '--'
  # Allowed keys to filter irrelevant arguments
  ALLOWED_ARGS = [KEY_POST, KEY_ARTICLE, KEY_HELP, KEY_DRYRUN].freeze
  # Help message to display if input is missing or invalid
  MSG_HELP = <<-END_HELP
      Arguments list is either missing or invalid. Valid arguments are:
        --post {post title}   generate a post with the given title. Spaces are replaced
                              by dashes. Only one post at a time
        --article {articles}  link the created post to the articles. Multiple articles
                              may be provided and will be generated. Article name
                              format must by "{tech/title}" where:
                              - "tech" is one word lowercase name of the technology
                              - "title" is multiple words, whatever case, space separated
        --date {date}         use a custom date. Format must be YYYY-MM-DD. Otherwise
                              today date is used
        --dryrun true         Perform a dryrun and does not create file. The 
                              "true" value is required
        --help                print this help message. Override other arguments 
                              and does not execute any generator
  END_HELP
    .freeze

  # ---------- self
  # Open to self method for convenience purpose
  def self.process
    post_generator = PostGenerator.new
    post_generator.process
  end

  # ---------- methods

  # process the arguments and generate appropriate files
  def process
    parsed_args = parse_arguments
    # +puts+ returns +nil+
    return puts MSG_HELP if requires_help?(parsed_args)

    add_missing_args!(parsed_args)
    puts "proceeding with #{parsed_args}"

    generate_posts(parsed_args)
    generate_articles(parsed_args)
  end

  # parse arguments and check if input is correct
  # @return [Hash] parsed allowed arguments and its values
  def parse_arguments
    ## group bby argument key
    arg_key = nil
    arg_hash = {}
    ARGV.each do |arg|
      # Attempt to extract a new key or use previous key if applicable
      arg_key = extract_arg_key(arg) || arg_key
      if !arg_key.nil? && extract_arg_key(arg).nil?
        arg_hash[arg_key] = (arg_hash[arg_key] || []) << arg
      end
    end

    arg_hash
  end

  # @param [String] arg raw input. Is expected to be starting via KEY_DETECTOR value
  # @return [Symbol] non-nil symbol if input is a valid inlut
  def extract_arg_key(arg)
    # invalid argument key
    return nil unless arg.start_with?(KEY_DETECTOR)

    # Strip KEY_DETECTOR and convert to symbol
    new_key = arg[KEY_DETECTOR.length, arg.length - KEY_DETECTOR.length]
    new_key = new_key.downcase.to_sym
    # Ensure it is valid
    return nil unless ALLOWED_ARGS.include?(new_key)

    # Return argument key
    new_key
  end

  # @param [Hash] args to be tested arguments
  # @return [Boolean] true if "help message" has to be displayed
  def requires_help?(args = {})
    args.empty? || args.key?(KEY_HELP)
  end

  # Adding missing arguments:
  # - date
  # @param [Hash] args initial input
  # @return [Hash] input filled with missing arguments
  def add_missing_args!(args)
    # add today date
    args[KEY_DATE] = Time.new.strftime('%Y-%m-%d') unless args.key?(KEY_DATE)
  end

  # create a file if dryrin is false
  # @param [String] path file path
  # @param [String] content file content
  # @param [Boolean] dryrun if true, only print file info
  def create_file(path, content, dryrun = false)
    if dryrun
      puts "DryRun: create file #{path} with content:\n$#{content}"
    else
      file = File.new(path, 'w')
      file.puts(content)
      file.close
      puts "Created: #{path}"
    end
  end

  # Generate all the posts provided by the input
  # @param [Hash] args input
  def generate_posts(args)
    posts, date, articles = args.values_at(KEY_POST, KEY_DATE, KEY_ARTICLE)
    dryrun = args[KEY_DRYRUN]
    if posts
      posts.each do |post|
        path, content = generate_post_info(date, post, articles)
        create_file(path, content, dryrun)
      end
    end
  end

  # Generate a single post
  # @param [String] date post data
  # @param [String] post_name post name without dash
  def generate_post_info(date, post_name, articles)
    # file path
    path = "./collections/_posts/#{date}-#{post_name.tr(' ', '-')}.md"
    # file content
    content = "---\ntitle: #{post_name}\n"
    content << "articles:\n"
    # related articles
    if articles
      articles.each do |article|
        content << "    - _kb/#{article.tr(' ', '-')}.md\n"
      end
    end
    content << "---\n"

    [path, content]
  end

  # Generate all the articles provided by the input
  # @param [Hash] args input
  def generate_articles(args)
    posts, date, articles = args.values_at(KEY_POST, KEY_DATE, KEY_ARTICLE)
    dryrun = args[KEY_DRYRUN]
    if articles
      articles.each do |article|
        path, content = generate_article_info(date, article, posts)
        create_file(path, content, dryrun)
      end
    end
  end

  # Generate a single post
  # @param [String] article_name article file name without dash in title
  # @param [String] posts related posts
  def generate_article_info(date, article_name, posts)
    path = "./collections/_kb/#{article_name.tr(' ', '-')}.md"

    article_name_split = article_name.split('/')
    article_tech = article_name_split[0]
    article_title = article_name_split[1].split.map(&:capitalize) * ' '

    content = "---\n"
    content << "tech: #{article_tech}\n"
    content << "title: #{article_title}\n"
    content << "mentioned:\n"
    if posts
      posts.each do |post|
        post_id = "/#{date.tr('-', '/')}/#{post.tr(' ', '-')}"
        content << "    - #{post_id}\n"
      end
    end
    content << "---\n"

    [path, content]
  end
end
