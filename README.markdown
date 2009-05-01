# Burndown

Burndown is a little app to help you keep tabs on your Lighthouse projects. It shows you how many tickets you open and close every day, along with a chart showing the progress along a milestone.

Still in progress.

## Deployment

If you want to make your life easy, go ahead and just deploy to [Heroku](http://heroku.com).  Burndown is ready to go for a deployment to Heroku, cron jobs and all!  If you want to set it up on your own, you'll need to make sure the tasks in `lib/tasks/cron.rake` get run once a day.