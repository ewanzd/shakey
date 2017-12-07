# Shakey

[Shakey](https://en.wikipedia.org/wiki/Shakey_the_robot) is the first general-purpose mobile robot to be able to reason about its own actions. In this project we simulate to logic part in [prolog](https://en.wikipedia.org/wiki/Prolog) to help shakey find an optimal way. For to do this we used the automated planning method [STRIPS](https://en.wikipedia.org/wiki/STRIPS).

## Getting started

Clone github repo

```sh
git clone https://github.com/ewanzd/shakey.git
```

In the projects root folder load the main prolog file

```sh
<your prolog interpreter> main.pl
```

In the prolog cli execute

```sh
test.
```

This is the test method.

## Configure project

You can configure several things

### Custom world

Create a custom scenario following the structure of one of the files in `scenarios/`.

Change the scenario import in the main file.

### Custom search algorithm

Create a custom search algorithm following the structure of one of the files in `searchAlgorithm/`.

Change the search algorithm import in the main file.

### Custom actions

Create actions in `actions/`. Import them in `actions.pl` and remove the ones you don't need.
