find app src test -type f | grep '^.*\.hs$' | grep -v 'src/Axel/Parse/Args.hs' | grep -v 'src/Axel.hs' | grep -v 'src/Axel/Haskell/Macros.hs' | xargs -L 1 hlint --color=always | grep -v 'No hints'
