# O Bank API

![alt-text](https://raw.githubusercontent.com/o-marchi/o-bank/master/src/assets/logo-green.png)
---


> O Bank is a project with the purpose of testing my skills for a job position at [Stone](https://www.stone.com.br/).
> All its content, logo, database registries are for this purpose only and do not represent a real company.
---

You can visit the project website on
[https://obank.tk/](https://obank.tk/).

---

It is a simple project where you can register a user and withdraw money from your bank account, as well as transfer money to another user.


### Running the project

Clone this repository, enter its folder and install the dependencies:

There you be no need to install `node` neither to run `npm i`, once this project serve no html/js.

```
mix deps.get
```
```
mix ecto.create
mix ecto.migrate
```

Then you can run the project using:
```
mix phx.server
```

It will be on [localhost:4000](http://localhost:4000) on your browser.
