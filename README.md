# Install Script/Upcoming Course

This is a work-in-progress script/project for an upcoming course.

It'll work like this:

1. You buy the course on [Flurly](https://flurly.com/)
2. It will redirect you to joeprevite.com/thanks-course-name (something like this)
3. There will be a command for you to run locally to install the course

The course will probably be on a topic related to JavaScript/TypeScript. It'll give you hands-on exercises that are each verified by a test.

## Installation

To run the install script locally as a dry-run, run:

```sh
curl -fsSL https://raw.githubusercontent.com/jsjoeio/install-scripts/main/install.sh | sh -s -- --dry-run
```

To see the actual code, take a look at [install.sh](./install.sh)

To actually install, run:

```sh
curl -fsSL https://raw.githubusercontent.com/jsjoeio/install-scripts/main/install.sh | sh -s -- --payment-id cs_live_a1VHFUz7lYnXOL3PUus13VbktedDQDubwfew8E70EvnS1BTOfNTSUXqO0i
```

## Docs

To see the documentation for the script, use the `--help` flag:

```sh
curl -fsSL https://raw.githubusercontent.com/jsjoeio/install-scripts/main/install.sh | sh -s -- --help
```

or read it here:

```text
Downloads the $COURSE_NAME for paid users.

USAGE:
  $install_method [OPTIONS] (-i|--payment_id) <payment_id>

OPTIONS:
  -d, --dry-run
      Echo the commands for the download process without running them.

  -h, --help
      Prints help information

ARGS:
  -i, --payment_id
      Required. Verifies course purchase.
      Example: $install_method --payment-id cs_live_a1VHFUz7lYnXOL3PUus13VbktedDQDubwfew8E70EvnS1BTOfNTSUXqO0i

More information can be found at https://github.com/jsjoeio/install-scripts
```

## LICENSE

[MIT](./LICENSE)
