Opinionated Rails Forum
=======================

This is a rails-based forum engine with some strong opinions:

 - Authentication is OpenID, creates new profile if needed
 - There are no forums/subforums
 - Topics are tagged
 - Tags are lowercase. By definition
 - Everyone can edit tags for a topic
 - A user is either normal or admin, no moderators
 - Avatars are gravatars
 - No smilies or sigs
 - Formatting is done with HTML
 - Posts may be edited and old versions are kept.
 - Private messages are email

## Install

 - Edit config/database.yml and run rake db:schema:load

## TODO

 - Give users a text box to add their own profile info
 - Remove 'quick' message mode, move posting inline
 - Replace Prototype with unobtrusive JavaScript (note TopicsController#new)
 - Show add/remove of tags in message flow
 - Expose post editing, acts_as_versioned the posts
 - private messaging via email
 - Set page <title> based on page contents
 - Feeds for new topics (all and by tag), new posts (all and by tag)
 - Create Search page using Google Site Search
 - Admin: option to split topics
 - Mark some tags as usable only by admins
