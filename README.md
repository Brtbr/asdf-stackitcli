<div align="center">

# asdf-stackitcli [![Build](https://github.com/brtbr/asdf-stackitcli/actions/workflows/build.yml/badge.svg)](https://github.com/brtbr/asdf-stackitcli/actions/workflows/build.yml) [![Lint](https://github.com/brtbr/asdf-stackitcli/actions/workflows/lint.yml/badge.svg)](https://github.com/brtbr/asdf-stackitcli/actions/workflows/lint.yml)

[stackitcli](https://github.com/stackitcloud/stackit-cli) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add stackitcli
# or
asdf plugin add stackitcli https://github.com/brtbr/asdf-stackitcli.git
```

stackitcli:

```shell
# Show all installable versions
asdf list-all stackitcli

# Install specific version
asdf install stackitcli latest

# Set a version globally (on your ~/.tool-versions file)
asdf global stackitcli latest

# Now stackitcli commands are available
stackit --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/brtbr/asdf-stackitcli/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Brtbr](https://github.com/brtbr/)
