This is an example of an entire project/study level BIDS dataset.
Built taking a hierarchy depicted on
https://github.com/neurodatascience/nipoppy?tab=readme-ov-file#nipoppy
and turning it into a valid BIDS layout.

Some files (e.g. bagel.csv) are specific to nipoppy etc projects, but since
located under folders where bids layout is not enforced -- should be just fine. 

Some outstanding issues with validator(s) which were ran into while trying to
get "proper" validation working using deno bids-validator (mark when solved)

- [ ] https://github.com/bids-standard/bids-validator/issues/2007

