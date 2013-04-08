quizlet-repo
============

A repository for the flash cards to upload to Quizlet


Getting started
===============


This specifically targets the creation of sets on Quizlet using the API and `quizlet-ruby` gem to make calls to the API.

An example QCSV (Quizlet CSV) in the `cards/inventions.qcsv` file, the title, terms language, and document language could be changed for a specific set. Note that the fallback language for terms and definitions if not specified will be _US English_. 

The bearer access token for the API to be used will require the `write_set` scope for the Quizlet 2.0 API.

The format of a command to upload for a given CSV is:

    ruby quizlet_upload.rb <path to .qcsv file> <access token>
