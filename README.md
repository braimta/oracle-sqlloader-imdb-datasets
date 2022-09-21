
# Introduction

This small project allows us to import [IMDd datasets](https://www.imdb.com/interfaces/) to an Oracle database. The model is kept easy and everything is loaded using SQL\*Loader.

# Pre-requisites

In order to run this project, the following tools are required:

1. An Oracle SQL*Client
2. cURL
3. envsubst

# Usage

Just run the load-all.sh script by providing credentials to the database. For instance:

```
% ./load-all.sh IMDB/"IMDB"@localhost:1521/ORCLPDB1
```


Feel free to contact [me](braimt@gmail.com) if you have any questions

---
Braim 