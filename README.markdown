# Burndown

Burndown is a little app to help you keep tabs on your Lighthouse projects. It shows you how many tickets you open and close every day, along with a chart showing the progress along a milestone.

## Deployment

If you want to make your life easy, go ahead and just deploy to [Heroku](http://heroku.com).  Burndown is ready to go for a deployment to Heroku, cron jobs and all!  If you want to set it up on your own, you'll need to make sure that `rake app:update_milestones` gets run once a day (preferably as late as possible in the day).  Running it multiple times a day has no negative impact.

## Getting started

Once you deploy the app, follow the instructions to set up some burndown charts. Then... wait! Burndown works by tracking progress every day. Which means you may have to wait a few days for your data to be interesting.