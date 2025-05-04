# nx-lis - lisp interaction server backend for Nyxt

Provides Slynk/Swank/Micros lisp interaction servers to connect to Nyxt
from Emacs or Lem (or other IDE of your choice that has support).

# Installation

Copy https://codeberg.org/loraz/nyxt-config/extensions/nx-lis by your method
of choice to `~/.local/share/nyxt/extensions`

After you've added `nx-lis` to a place that Nyxt can find it, it is
necessary to load it in your init file. To do this, it suffices to add
the following:

```lisp

 (nyxt:define-nyxt-user-system-and-load "nyxt-user/nx-lis-proxy"
                                        :depends-on ("nx-lis"))
```

Now you can start either Micros/Slynk/Swank in Nyxt with the following commands:

 - `M-x start-micros`
 - `M-x start-slynk`
 - `M-x start-swank` 

## Dependencies

 - nyxt
 - micros
 - slynk
 - swank

  I personally use [ocicl](https://github.com/ocicl/ocicl) for my Common Lisp
package management tool (prefer it over quicklisp and the others out there). The default
OCICL configuration sets ASDF to search the current working director for an ocicl directory 
and installs dependencies there. This is preferred for me as it keeps dependencies modular 
(and you can install stuff globally if multiple projects use the same library).

Once ocicl is installed, you can install your dependencies via their CLI as follows:

```bash

 $ ocicl install micros slynk swank

```

Or you can do it from within a lisp repl (sbcl):

```lisp

 * (asdf:load-systems :micros :slynk :swank)

```

Either of these methods will create an `ocicl` directory and a file (ocicl.csv) listing
the installed dependencies.
