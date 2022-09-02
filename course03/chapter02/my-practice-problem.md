# create kubernetes job that prints hello world in the console.
Solve it with vim and k8s documentation
I was able to solve the challenge!

# Create a cron job that runs every one minute and print 'Hello Minutely Cron Job'
- Had to look for cron reference in google.
- active deadline seconds : max time allowed for the job to run  (activeDeadlineSeconds)

- The restartPolicy for jobs and cron jobs must be set to never or onFailure. not Always.
- Why multi container pods? because i want them to share resources(network and volume)