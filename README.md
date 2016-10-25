# pud-quicklook

Pud-Quicklook is a [Quicklook](https://en.wikipedia.org/wiki/Quick_Look) plug-in to preview PUD files.
PUD files are Warcraft II custom maps, that can be created via editors such as Blizzard's default World Map Editor or [war2edit](https://war2.github.io/war2edit/).

Pud-Quicklook relies on the `libpud`. More details can be found there: https://github.com/war2/war2tools.


## Build

Basically:

```bash
make
sudo make install
```

To uninstall, you can manually remove the `pud-quicklook` Plugin from the Finder (in `/Library/QuickLook`) or run:

```bash
sudo make uninstall
```

## License

The Pud quicklook plugin in under the MIT license. See `LICENSE` for mode details.
