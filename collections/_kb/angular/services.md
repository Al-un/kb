---
tech: angular
title: Services
---

## Injection

Services uses [dependency injection](https://angular.io/guide/dependency-injection)
and injection scope is defined by `providedIn:`

```ts
import { Injectable } from "@angular/core";
import { HEROES } from "./mock-heroes";

@Injectable({
  // we declare that this service should be created
  // by the root application injector.
  providedIn: "root"
})
export class HeroService {
  getHeroes() {
    return HEROES;
  }
}
```

Used in a class:

```ts
import { Component } from "@angular/core";
import { Hero } from "./hero";
import { HeroService } from "./hero.service";

@Component({
  selector: "app-hero-list",
  template: `
    <div *ngFor="let hero of heroes">{{ hero.id }} - {{ hero.name }}</div>
  `
})
export class HeroListComponent {
  heroes: Hero[];

  constructor(heroService: HeroService) {
    this.heroes = heroService.getHeroes();
  }
}
```

## Abstract services

Let's consider:

- `AbstService` the abstract class
- `TextService` text version of the service
- `NumServuce` numeric version of the service

```ts
// abst.service.ts
import { Injectable } from "@angular/core";

@Injectable()
export abstract class AbstService {
  constructor() {}

  // Same someText
  public someText(): string {
    return "some text";
  }

  // Different moart text
  abstract moarText(input: string): string;
}

// text.service.ts
import { Injectable } from "@angular/core";
import { AbstTextService } from "./abst.service";

@Injectable()
export class TextService extends AbstTextService {
  constructor() {
    super();
  }

  moarText(input: string): string {
    return "Moar " + input;
  }
}

// num.service.ts
import { Injectable } from "@angular/core";
import { AbstTextService } from "./abst.service";

@Injectable()
export class NumService extends AbstTextService {
  constructor() {
    super();
  }

  moarText(input: string): string {
    return input + "+++";
  }
}
```

Select the implementation you want to use via the `provider`

```ts
// At component level
@Component({
  providers: [{ provide: AbstService, useClass: TextService }]
})

// At module level
@NgModule({
  providers: [{ provide: AbstService, useClass: NumService }]
})
```
