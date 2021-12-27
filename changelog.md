# Changelog

## Unreleased

### Added 

* Ledger version
* `creatorDetails` for `PaymentRequest`, `ManageOfferRequest`
* Result codes for `CreatePaymentRequest`, `CreateManageOfferRequest`

### Fixed
* Updated `ManageSaleResultSuccess` union switch to resolve issue with missing ref to the result schema

## 3.7.2

### Added

* New ledger version

## 3.7.1

### Added

* Error code for create redemption operation

## 3.7.0

### Added

* redemption reviewable request

## 3.6.0

### Added

* new LedgerVersion for marking asset as deleted
* asset operation error codes

## 3.5.0

### Added

* new LedgerVersion
* `RemoveAsset` operation
* `REMOVE_FOR_OTHER` account rule action 
* `REMOVE_FOR_OTHER` signer rule action
* `CreateManageOfferRequest` operation
* `CreatePaymentRequest` operation
* `CREATE_PAYMENT` reviewable request type
* `MANAGE_OFFER` reviewable request type
* `IMMEDIATE` sale type
*  Account rule resources
*  Signer rule resources 

## 3.4.1

### Added

* New ledger version
* New ledger version added to fix create kyc recovery permissions 

## 3.4.0

### Added

* New ledger version to handle rules for `AccountSpecificRule`
* Rule entries for `AccountSpecificRule`
* Added new ledger version to fix deposit statistics v2
* `RemoveAssetPairOp` operation
* Error codes and useful fields in success result for create atomic swap bid and atomic swap ask request operations
* `CREATE_ATOMIC_SWAP_BID` and `CREATE_ATOMIC_SWAP_ASK` case to reviewable request resource
* `InitiateKYCRecovery` operation
* `KYC_Recovery` reviewable request
* `CreateKYCRecoveryRequest` operation
* New LedgerVersion to fix investment fee
* New LedgerVersion to fix same asset pair creation
* New `ManageAssetPairOp` error code

### Changed

* atomic swap ask and atomic swap bid structs' names

## 3.3.1

### Fixed
* Updated xdrgen for docs generation to resolve issue with union switches showing redundant arms

### Added
* Shortcut to contact support

## 3.3.0

### Added

* Error codes for create change role request
* Error codes for review request
* New LedgerVersion to fix change to unexisting role
* New ledger version to fix positive error codes of create aml alert request
* New AML Alert error codes
* Operation to cancel change role request
* New ledger version to fix creating reverse pairs while creating sale
* New LedgerVersion to fix checking permissions to set allTasks
* New LedgerVersion to fix getting expiration time from KeyValue storage on external account prolongation
* Account Specific Rules Creation and Removal
* Account Specific Rules for sales

## 3.2.0

### Added

* Manage poll actions: `CLOSE`, `UPDATE_END_TIME`
* Account rule action `UPDATE_END_TIME`
* Signer rule action `UPDATE_END_TIME`
* Invest fee

## 3.1.2
### Added
* Added new ledger version to fix payment statistics v2

## 3.1.1

### Added

* Add optional pollID field in CreatePollRequestResponse result

## 3.1.0

### Added

* Poll entry and `CREATE_POLL` request
* Manage `CREATE_POLL` request operation
* Manage poll operation
* Manage vote operation and vote entry

## 3.0.1-x.0

### Added

* Error codes for set fee op result
* Error codes for manage limits and review limits request ops results

## 3.0.0

### Added

* Comments for docs to CreateChangeRoleRequestOp
* Comments for docs to ManageSignerRuleOp
* Comments for docs to SignerRuleResource
* Comments for docs to ManageSignerOp
* Comments for docs to ManageSignerRoleOp
* Comments for docs to CreateAccountOp
* Comments for docs to ManageAccountRoleOp
* Comments for docs to ManageAccountRuleOp
* Comments for docs to AccountRuleResource
* Comments for docs to ManageAssetOp
* Comments for docs to CreatePreIssuanceRequestOp and preIssuanceRequest
* Comments for docs to CreateSaleCreationRequestOp
* Comments for docs to CheckSaleStateOp
* Comments for docs to CancelSaleCreationRequestOp
* Comments for docs to ManageSaleOp
* Comments for docs to ManageOfferOp
* Comments for docs to CreateIssuanceRequestOp
* Comments for docs to CreateWithdrawalRequestOp
* Comments for docs to CreateAMLAlertRequestOp
* Comments for docs to LicenseOp
* Comments for docs to StampOp
* Comments for docs to ReviewRequestOp
* Comments for docs to BindExternalSystemAccountIdOp
* Comments for docs to ManageExternalSystemAccountIdPoolEntryOp
* Comments for docs to ManageKeyValueOp
* Comments for docs to ManageAssetPairOp
* Comments for docs to ManageLimitsOp and LimitsUpdateRequest
* Comments for docs to ManageBalanceOp
* Comments for docs to PaymentOp
* Comments for docs to SetFeesOp and FeeEntry

* Signer rule and role entries
* Manage signer rule and role ops
* Signer rule resource
* signer entry
* manage signer operation
* Error code to manage key value op
* Specify key value resource for rule
* Add error code to set fee op
* Payload to NO_ROLE_PERMISSION error code
* LicenseOp, StampOp, License entry, Stamp entry

### Changed

* Replace opNO_BALANCE etc. operation error codes by opNO_ENTRY
* Create account op
* Use consistent name of fields for RequestTypedResource (ReviewableRequestResource)
* Use forbids name of filed in rules
* Use consistently names of role and rule ids
* Error codes for create change role request op
* Error codes for invalid creator details
* Rename kycData to creator Details
* Rename paymentV2 to payment
* Add isBuy to rule resources
* Add withdraw case to request resource

### Removed

* Set option op
* manage account op
* account type limits entry
* trust
* signer types and signer struct
* account types

### Fixed

### Security
