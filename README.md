[Homebrew](https://brew.sh) tap for [reception](https://github.com/ninech/reception).

## Usage

    brew tap ninech/homebrew-reception
    brew install reception

## How to bottle

    brew install --build-bottle reception
    brew bottle reception

1. Copy the output to `Formula/reception.rb`.
2. Commit & Push the change.
3. Create a new release called "v{VERSION_FROM_TAR_GZ_FILE}".
   file.
4. Attach the tar.gz file to the release
