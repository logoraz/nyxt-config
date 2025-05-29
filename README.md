# nyxt-config - Nyxt Browswer Configuration 

Personal configuration for the highly extensible Nyxt Browser with batteries included. 

PS: Only tested and used on Fedora 42 Workstation...

<p align="center">
  <img src="assets/nyxt.svg" width="200" />
</p>


## Dependencies
  - [nyxt](https://github.com/atlas-engineer/nyxt)
  - [ocicl](https://github.com/ocicl/ocicl)
  - `nx-nord-theme` (Included - A dark Nord theme based on Nyxt's Invader theme)
  - `nx-lis` (Included - Lisp Interaction Servers Extension)
     - micros
     - slynk
     - swank
  - `nx-code` (Included - *WIP* A modern extensible emacs-like IDE extension for Nyxt)
     - [cl-treesitter](https://github.com/garlic0x1/cl-treesitter)


## Installation/Setup
Download this repo from `https://github.com/logoraz/nyxt-config`:

```bash
   $ cd ~/.config
   $ git clone https://github.com/logoraz/nyxt-config.git nyxt
```

Next, setup extensions directory to utilize the "batteries" included with this
configuration:

```bash
   $ cd nyxt
   $ sbcl --load setup.lisp
```

This script ensures `~/.local/share/nyxt/` directory exists, then creates a symlink
from `~/.config/nyxt/extensions` to `~/.local/share/nyxt/extensions/`


### Loading Common Lisp dependencies required for extensions
I use [ocicl](https://github.com/ocicl/ocicl) for my external Common Lisp systems
management because it provides a lot of conveniency and is far more superior and 
more secure than the other distribution tools out there that depend on quicklisp 
(namely qlot, roswell, ultralisp, etc.). It's time to move away from quicklisp
folks!

First, install `ocicl` following the install instructions on their readme.

Next, let's install the external dependencies for `nx-lis`, a trivial Lisp Interaction 
Servers extension I created for Nyxt:

```bash
   $ cd ~/.config/nyxt/extensions/nx-lis/
   # Dependencies are specified in 'ocicl.csv'
   $ ocicl install
```

A neat feature of the `ocicl` command line tool - I suggested and the folks at `ocicl`
quickly implemented - is `tree`, which lists out installed dependencies, you can trial it out
as follows to see what dependencies were installed above:

```bash
   $ ocicl tree --depth=4
   #/home/<username>/.config/nyxt/extensions/nx-lis/ocicl.csv
   #├─ micros
   #├─ slynk
   #└─ swank
```

If you are feeling daring, you can hack my current experimental extension
`nx-code`, a modern emacs-like IDE I am developing for nyxt. To do so, you will
need to install the Fedora packages to compile `cl-treesitter`:

Fedora dependencies:
```bash
   $ sudo dnf group install c-development development-tools
   $ sudo dnf install libtree-sitter-devel
```

Now lets get the `cl-treesitter` source and compile:
```bash
   # First retrieve the source of `cl-treesitter'
   $ cd ~/.config/nyxt/extensions/nx-code/
   $ mkdir ocicl && cd ocicl
   $ git clone https://github.com/garlic0x1/cl-treesitter.git
   $ cd cl-treesitter
   # Installs/Compiles shim.c required for cl-treesitter
   # ocicl will handle any of the external dependencies required therein...
   $ sbcl --eval "(asdf:load-system 'cl-treesitter) (sb-ext:quit)"
``

If not, you can easily disable in the config by commenting out or deleting the
following line of code:

```lisp
  ;;(defextsystem nx-code)
```


## TODOs (Wish List)
  - Establish custom keybindings...
  - Continue efforts on developing `nx-code`, an emacs-like IDE for Nyxt.
  - tbd


## References:
  - https://github.com/atlas-engineer/nyxt
  - https://github.com/aartaka/nyxt-config
  - tbd
