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

## Topics

There are two kinds of topics:

 - **Normal**: These topics always show their entire contents.
    
 - **Continuous**: These topics are more like a chat room than like a forum topic. They show only the latest 30 or so messages, and provide you with a paginated archive when you really need the history.

## Install

 - Edit config/database.yml and run rake db:schema:load

## TODO

 - replace last of erb with haml
 - Mark some tags as usable only by admins
 - get css out of views
 - Admin: option to split topics
 - Only admins and users themselves should be able to edit a user's profile
 - Only admins should have the Admin checkbox on profile editing
 - Reserve title editing for original poster and admins
 - Replace Prototype with unobtrusive JavaScript (note TopicsController#new)
 - Create Search page using Google Site Search
 - Give users a text box to add their own profile info
 - When switching message modes, preserve message
 - In large message mode, post/cancel buttons overlap right column
 - Set page <title> based on page contents
 - Expose post editing, acts_as_versioned the posts
 - integrate https://www.idselector.com/ on login
 - private messaging via email
