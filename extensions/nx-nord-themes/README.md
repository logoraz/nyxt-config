# nx-nord-themes - A suite of Nord Themes for Nyxt

Currently only have a contrast dark theme implemented for Nyxt, invader-dark.

## Installation

Copy https://github.com/logoraz/nxconfig/extensions/nx-nord-themes by your method
of choice to `~/.local/share/nyxt/extensions`

After you've added `nx-nord-themes` to a place that Nyxt can find it, it is
necessary to load it in your init file. To do this, it suffices to add
the following:

```lisp

 (nyxt:define-nyxt-user-system-and-load "nyxt-user/nx-lis-proxy"
                                        :depends-on ("nx-nord-themes"))
```

To enable theme in your config, add the following code:

```lisp
;; Defined in proper order - theme has to first be loaded into browser, then status buffer is updated.
(define-configuration :browser
  ((theme *ice-dark-theme*)))

(define-configuration :status-buffer
  ((style (str:concat %slot-value%
                      (theme:themed-css (theme *browser*))))))
```

## Dependencies

 - TBD


## References