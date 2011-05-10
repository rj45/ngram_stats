Intro
-----

This is a pragmatic exploration of the data at:

http://ngrams.googlelabs.com/datasets

Most of this is a hack designed to quickly answer a few questions. One of which being:

If you were to teach a student english, what are the first words you should teach?

I am making a huge (and problably invalid) assumption that the most frequent words 
in the english language are the ones you should teach first. Hopefully if this 
assumption is indeed invalid, the result will still be close to useful.

Pragmatics
----------

Really, if this code were used every day in a real app, it would be written in a more 
agile way, and unit tested. However, I don't plan to recalculate the answer to this 
problem any time in the near future and I'd rather get it done instead of fuss about 
best practices. So no unit tests :-(

The Data
--------

http://ngrams.googlelabs.com/datasets

A downloader is included to download and recompress the 1-gram data set.

Prerequisites
-------------

* wget
* lzma (and lzcat)
* unzip
* ruby 1.9.2

WTF LZMA?!?!?!
--------------

I don't have a lot of disk space. I evaluated several algorithms and I found not only 
is LZMA the smallest, it decompresses very fast. The only downside is it takes 
~30 minutes for a single core to compress one file. I just left it go overnight ;-)

But, but, Ruby doesn't have a LZMA library!
-------------------------------------------

It does but it requires the whole file fit in RAM which... uh... it might, but meh. 

lzcat works just fine. Welcome to unix pipes. Let's just get this done.

Ruby Ruby
---------

This was written and tested under Ruby 1.9.2. It might work in other rubies.

How do run?
-----------

* use git to clone the repo
* ruby bin/downloader.rb
* ruby bin/run.rb bin/filter.rb > data/unsorted-result.csv
* sort data/unsorted-result.rb > data/sorted-result.csv

WTF I want to SUE!!
-------------------

This software is public domain. Do whatever you want with it, but it is provided AS IS 
without any warranty expressed or implied. If you use this code to dominate the world,
there is no need to give me credit (in fact, in that case, please don't).
