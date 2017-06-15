# Shakey

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

### Custom actions

Create actions in `actions/`. Import them in `actions.pl` and remove the ones you don't need.
