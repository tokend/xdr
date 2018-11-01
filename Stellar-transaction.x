// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"
%#include "xdr/Stellar-operation-create-account.h"
%#include "xdr/Stellar-operation-payment.h"
%#include "xdr/Stellar-operation-set-options.h"
%#include "xdr/Stellar-operation-set-fees.h"
%#include "xdr/Stellar-operation-manage-account.h"
%#include "xdr/Stellar-operation-create-withdrawal-request.h"
%#include "xdr/Stellar-operation-manage-balance.h"
%#include "xdr/Stellar-operation-manage-asset.h"
%#include "xdr/Stellar-operation-create-preissuance-request.h"
%#include "xdr/Stellar-operation-create-issuance-request.h"
%#include "xdr/Stellar-operation-manage-limits.h"
%#include "xdr/Stellar-operation-manage-asset-pair.h"
%#include "xdr/Stellar-operation-direct-debit.h"
%#include "xdr/Stellar-operation-manage-offer.h"
%#include "xdr/Stellar-operation-manage-invoice-request.h"
%#include "xdr/Stellar-operation-review-request.h"
%#include "xdr/Stellar-operation-create-sale-creation-request.h"
%#include "xdr/Stellar-operation-cancel-sale-creation-request.h"
%#include "xdr/Stellar-operation-check-sale-state.h"
%#include "xdr/Stellar-operation-payout.h"
%#include "xdr/Stellar-operation-create-AML-alert-request.h"
%#include "xdr/Stellar-operation-manage-key-value.h"
%#include "xdr/Stellar-operation-create-KYC-request.h"
%#include "xdr/Stellar-operation-manage-external-system-id-pool-entry.h"
%#include "xdr/Stellar-operation-bind-external-system-id.h"
%#include "xdr/Stellar-operation-payment-v2.h"
%#include "xdr/Stellar-operation-manage-sale.h"
%#include "xdr/Stellar-operation-create-manage-limits-request.h"
%#include "xdr/Stellar-operation-manage-contract.h"
%#include "xdr/Stellar-operation-manage-contract-request.h"
%#include "xdr/Stellar-operation-manage-settlement-option.h"
%#include "xdr/Stellar-operation-manage-investment-token-sale-creation-request.h"
%#include "xdr/Stellar-operation-create-investment-token-sale-participation.h"
%#include "xdr/Stellar-operation-perform-settlement.h"
%#include "xdr/Stellar-operation-manage-account-role.h"
%#include "xdr/Stellar-operation-manage-account-role-permission.h"

namespace stellar
{

/* An operation is the lowest unit of work that a transaction does */
struct Operation
{
    // sourceAccount is the account used to run the operation
    // if not set, the runtime defaults to "sourceAccount" specified at
    // the transaction level
    AccountID* sourceAccount;

    union switch (OperationType type)
    {
    case CREATE_ACCOUNT:
        CreateAccountOp createAccountOp;
    case PAYMENT:
        PaymentOp paymentOp;
    case SET_OPTIONS:
        SetOptionsOp setOptionsOp;
	case CREATE_ISSUANCE_REQUEST:
		CreateIssuanceRequestOp createIssuanceRequestOp;
    case SET_FEES:
        SetFeesOp setFeesOp;
	case MANAGE_ACCOUNT:
		ManageAccountOp manageAccountOp;
	case CREATE_WITHDRAWAL_REQUEST:
		CreateWithdrawalRequestOp createWithdrawalRequestOp;
	case MANAGE_BALANCE:
		ManageBalanceOp manageBalanceOp;
    case MANAGE_ASSET:
        ManageAssetOp manageAssetOp;
    case CREATE_PREISSUANCE_REQUEST:
        CreatePreIssuanceRequestOp createPreIssuanceRequest;
    case MANAGE_LIMITS:
        ManageLimitsOp manageLimitsOp;
    case DIRECT_DEBIT:
        DirectDebitOp directDebitOp;
	case MANAGE_ASSET_PAIR:
		ManageAssetPairOp manageAssetPairOp;
	case MANAGE_OFFER:
		ManageOfferOp manageOfferOp;
    case MANAGE_INVOICE_REQUEST:
        ManageInvoiceRequestOp manageInvoiceRequestOp;
	case REVIEW_REQUEST:
		ReviewRequestOp reviewRequestOp;
	case CREATE_SALE_REQUEST:
		CreateSaleCreationRequestOp createSaleCreationRequestOp;
	case CHECK_SALE_STATE:
		CheckSaleStateOp checkSaleStateOp;
	case PAYOUT:
	    PayoutOp payoutOp;
	case CREATE_AML_ALERT:
	    CreateAMLAlertRequestOp createAMLAlertRequestOp;
	case MANAGE_KEY_VALUE:
	    ManageKeyValueOp manageKeyValueOp;
	case CREATE_KYC_REQUEST:
		CreateUpdateKYCRequestOp createUpdateKYCRequestOp;
    case MANAGE_EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY:
        ManageExternalSystemAccountIdPoolEntryOp manageExternalSystemAccountIdPoolEntryOp;
    case BIND_EXTERNAL_SYSTEM_ACCOUNT_ID:
        BindExternalSystemAccountIdOp bindExternalSystemAccountIdOp;
    case PAYMENT_V2:
        PaymentOpV2 paymentOpV2;
    case MANAGE_SALE:
        ManageSaleOp manageSaleOp;
    case CREATE_MANAGE_LIMITS_REQUEST:
        CreateManageLimitsRequestOp createManageLimitsRequestOp;
    case MANAGE_CONTRACT_REQUEST:
        ManageContractRequestOp manageContractRequestOp;
    case MANAGE_CONTRACT:
        ManageContractOp manageContractOp;
    case CANCEL_SALE_REQUEST:
        CancelSaleCreationRequestOp cancelSaleCreationRequestOp;
    case MANAGE_INVESTMENT_TOKEN_SALE_CREATION_REQUEST:
        ManageITSaleCreationRequestOp manageITSaleCreationRequestOp;
    case CREATE_INVESTMENT_TOKEN_SALE_PARTICIPATION:
        CreateITSaleParticipationOp createITSaleParticipationOp;
    case MANAGE_SETTLEMENT_OPTION:
        ManageSettlementOptionOp manageSettlementOptionOp;
    case PERFORM_SETTLEMENT:
        PerformSettlementOp performSettlementOp;
    case MANAGE_ACCOUNT_ROLE:
        ManageAccountRoleOp manageAccountRoleOp;
    case MANAGE_ACCOUNT_ROLE_PERMISSION:
        ManageAccountRolePermissionOp manageAccountRolePermissionOp;
    }
    body;
};

enum MemoType
{
    MEMO_NONE = 0,
    MEMO_TEXT = 1,
    MEMO_ID = 2,
    MEMO_HASH = 3,
    MEMO_RETURN = 4
};

union Memo switch (MemoType type)
{
case MEMO_NONE:
    void;
case MEMO_TEXT:
    string text<28>;
case MEMO_ID:
    uint64 id;
case MEMO_HASH:
    Hash hash; // the hash of what to pull from the content server
case MEMO_RETURN:
    Hash retHash; // the hash of the tx you are rejecting
};

struct TimeBounds
{
    uint64 minTime;
    uint64 maxTime; // 0 here means no maxTime
};

/* a transaction is a container for a set of operations
    - is executed by an account
    - fees are collected from the account
    - operations are executed in order as one ACID transaction
          either all operations are applied or none are
          if any returns a failing code
*/

struct Transaction
{
    // account used to run the transaction
    AccountID sourceAccount;

    Salt salt;

    // validity range (inclusive) for the last ledger close time
    TimeBounds timeBounds;

    Memo memo;

    Operation operations<100>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ADD_TRANSACTION_FEE:
        uint64 maxTotalFee;
    }
    ext;
};

/* A TransactionEnvelope wraps a transaction with signatures. */
struct TransactionEnvelope
{
    Transaction tx;
    DecoratedSignature signatures<20>;
};

/* High level Operation Result */

enum OperationResultCode
{
    opINNER = 0, // inner object result is valid

    opBAD_AUTH = -1,      // too few valid signatures / wrong network
    opNO_ACCOUNT = -2,    // source account was not found
	opNOT_ALLOWED = -3,   // operation is not allowed for this type of source account
	opACCOUNT_BLOCKED = -4, // account is blocked
    opNO_COUNTERPARTY = -5,
    opCOUNTERPARTY_BLOCKED = -6,
    opCOUNTERPARTY_WRONG_TYPE = -7,
    opBAD_AUTH_EXTRA = -8,
    opNO_ROLE_PERMISSION = -9 // not allowed for this role of source account
};

union OperationResult switch (OperationResultCode code)
{
case opINNER:
    union switch (OperationType type)
    {
    case CREATE_ACCOUNT:
        CreateAccountResult createAccountResult;
    case PAYMENT:
        PaymentResult paymentResult;
    case SET_OPTIONS:
        SetOptionsResult setOptionsResult;
	case CREATE_ISSUANCE_REQUEST:
		CreateIssuanceRequestResult createIssuanceRequestResult;
    case SET_FEES:
        SetFeesResult setFeesResult;
	case MANAGE_ACCOUNT:
		ManageAccountResult manageAccountResult;
    case CREATE_WITHDRAWAL_REQUEST:
		CreateWithdrawalRequestResult createWithdrawalRequestResult;
    case MANAGE_BALANCE:
        ManageBalanceResult manageBalanceResult;
    case MANAGE_ASSET:
        ManageAssetResult manageAssetResult;
    case CREATE_PREISSUANCE_REQUEST:
        CreatePreIssuanceRequestResult createPreIssuanceRequestResult;
    case MANAGE_LIMITS:
        ManageLimitsResult manageLimitsResult;
    case DIRECT_DEBIT:
        DirectDebitResult directDebitResult;
	case MANAGE_ASSET_PAIR:
		ManageAssetPairResult manageAssetPairResult;
	case MANAGE_OFFER:
		ManageOfferResult manageOfferResult;
	case MANAGE_INVOICE_REQUEST:
		ManageInvoiceRequestResult manageInvoiceRequestResult;
	case REVIEW_REQUEST:
		ReviewRequestResult reviewRequestResult;
	case CREATE_SALE_REQUEST:
		CreateSaleCreationRequestResult createSaleCreationRequestResult;
	case CHECK_SALE_STATE:
		CheckSaleStateResult checkSaleStateResult;
	case PAYOUT:
	    PayoutResult payoutResult;
	case CREATE_AML_ALERT:
	    CreateAMLAlertRequestResult createAMLAlertRequestResult;
	case MANAGE_KEY_VALUE:
	    ManageKeyValueResult manageKeyValueResult;
	case CREATE_KYC_REQUEST:
	    CreateUpdateKYCRequestResult createUpdateKYCRequestResult;
    case MANAGE_EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY:
        ManageExternalSystemAccountIdPoolEntryResult manageExternalSystemAccountIdPoolEntryResult;
    case BIND_EXTERNAL_SYSTEM_ACCOUNT_ID:
        BindExternalSystemAccountIdResult bindExternalSystemAccountIdResult;
    case PAYMENT_V2:
        PaymentV2Result paymentV2Result;
    case MANAGE_SALE:
        ManageSaleResult manageSaleResult;
    case CREATE_MANAGE_LIMITS_REQUEST:
        CreateManageLimitsRequestResult createManageLimitsRequestResult;
    case MANAGE_CONTRACT_REQUEST:
        ManageContractRequestResult manageContractRequestResult;
    case MANAGE_CONTRACT:
        ManageContractResult manageContractResult;
    case CANCEL_SALE_REQUEST:
        CancelSaleCreationRequestResult cancelSaleCreationRequestResult;
    case MANAGE_INVESTMENT_TOKEN_SALE_CREATION_REQUEST:
        ManageITSaleCreationRequestResult manageITSaleCreationRequestResult;
    case CREATE_INVESTMENT_TOKEN_SALE_PARTICIPATION:
        CreateITSaleParticipationResult createITSaleParticipationResult;
    case MANAGE_SETTLEMENT_OPTION:
        ManageSettlementOptionResult manageSettlementOptionResult;
    case PERFORM_SETTLEMENT:
        PerformSettlementResult performSettlementResult;
    case MANAGE_ACCOUNT_ROLE:
        ManageAccountRoleResult manageAccountRoleResult;
    case MANAGE_ACCOUNT_ROLE_PERMISSION:
        ManageAccountRolePermissionResult manageAccountRolePermissionResult;
    }
    tr;
default:
    void;
};

enum TransactionResultCode
{
    txSUCCESS = 0, // all operations succeeded

    txFAILED = -1, // one of the operations failed (none were applied)

    txTOO_EARLY = -2,         // ledger closeTime before minTime
    txTOO_LATE = -3,          // ledger closeTime after maxTime
    txMISSING_OPERATION = -4, // no operation was specified

    txBAD_AUTH = -5,             // too few valid signatures / wrong network
    txNO_ACCOUNT = -6,           // source account not found
    txBAD_AUTH_EXTRA = -7,       // unused signatures attached to transaction
    txINTERNAL_ERROR = -8,       // an unknown error occured
	txACCOUNT_BLOCKED = -9,      // account is blocked and cannot be source of tx
    txDUPLICATION = -10,         // if timing is stored
    txINSUFFICIENT_FEE = -11,    // the actual total fee amount is greater than the max total fee amount, provided by the source
    txSOURCE_UNDERFUNDED = -12,  // not enough tx fee asset on source balance
    txCOMMISSION_LINE_FULL = -13 // commission tx fee asset balance amount overflow
};

struct OperationFee
{
    OperationType operationType;
    uint64 amount;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct TransactionFee
{
    AssetCode assetCode;
    OperationFee operationFees<100>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct TransactionResult
{
    int64 feeCharged; // actual fee charged for the transaction

    union switch (TransactionResultCode code)
    {
    case txSUCCESS:
    case txFAILED:
        OperationResult results<>;
    default:
        void;
    }
    result;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    case ADD_TRANSACTION_FEE:
        TransactionFee transactionFee;
    }
    ext;
};
}
