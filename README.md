# Simplybetter

Getting ideas from your registered users/customers should be simple!

 - Simple install
 - Simple usage, no second registration
 - Your app, your user, your ideas, your control

## Help

### Find similar ideas while writing title is not working!
We use elastic search for this, and it might be because the index somehow is out of sync. Try running `Idea.reindex`

### Reverse routing in angular

#### Redirect fra en kontroller
1. Inject 'Redirect' inn i kontrolleren
2. Metoden ser slik ut: `Redirect(name, options, urlParameters)`

**Eksempel 1:**
`Redirect('idea', { id: 2 })` Returnerer: `#/widget/ideas/2`

**Eksempel 2:**
Noen ganger trenger vi å legge på ekstra url-parametre på slutten
`Redirect('idea_edit', { id: 3 }, '?comment_id=4')` Returnerer: `#/widget/ideas/3/edit?comment_id=4`
#### Links

For å lage lenker i templates, kan vi bruke fremgangsmåten beskrevet her: https://github.com/airtonix/angular-named-routes#directive


### Email preview
Preview email example to preview password_reset: /rails/mailers/customer_mailer/password_reset

/rails/mailers/{file}/{method}


### Auto deploy to heroku

We have enabled [auto-deploy](https://devcenter.heroku.com/articles/github-integration) to heroku. The develop branch will automatically be deployed to staging. 
We have also enabled [review apps](https://devcenter.heroku.com/articles/github-integration-review-apps). This means that all PR will automatically create a new temporary application on heroku for testing. The file app.json file is config for review-apps

### Bower

We are using bower for assets. [Simple guide for bower and rails](http://dotwell.io/taking-advantage-of-bower-in-your-rails-4-app/).

#### Install bower
`npm install -g bower`

#### Update assets
Modify `bower.json` run `bower install`