quizlet-repo
============

A repository for the flash cards to upload to Quizlet

This specifically targets the creation of sets on Quizlet using the API and `quizlet-ruby` gem to make calls to the API.

An example QCSV (Quizlet CSV) in the `cards/inventions.qcsv`

The format of a command to upload for a given CSV is:
    ruby quizlet_upload.rb <path to .qcsv file> <access token>
