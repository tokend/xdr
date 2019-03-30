# Changelog

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
