## Overview
This repository defines base structures used in the TokenD based network to store ledger state and to craft transactions.
This repo should be used as submodule. Do not commit any language specific data.

## Changelog

All notable changes to this project will be documented in [this file](https://github.com/tokend/xdr/blob/master/changelog.md). This project adheres to Semantic Versioning.

## Notes

This repo has been forked from [Stellar XDR](https://github.com/stellar/stellar-core)

## Generate docs 

1. Make sure `bundle` is installed and you have run `bundle install`
1. Make sure that correct version of redoc-cli is installed. `npm uninstall -g redoc-cli` and `npm install -g @tokend/redoc-cli`
1. Run `make`