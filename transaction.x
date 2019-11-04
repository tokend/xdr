// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/ledger-entries.h"
%#include "xdr/operation-create-account.h"
%#include "xdr/operation-set-fees.h"
%#include "xdr/operation-create-withdrawal-request.h"
%#include "xdr/operation-manage-balance.h"
%#include "xdr/operation-manage-asset.h"
%#include "xdr/operation-create-preissuance-request.h"
%#include "xdr/operation-create-issuance-request.h"
%#include "xdr/operation-manage-limits.h"
%#include "xdr/operation-manage-asset-pair.h"
%#include "xdr/operation-manage-offer.h"
%#include "xdr/operation-manage-invoice-request.h"
%#include "xdr/operation-review-request.h"
%#include "xdr/operation-create-sale-creation-request.h"
%#include "xdr/operation-cancel-sale-creation-request.h"
%#include "xdr/operation-check-sale-state.h"
%#include "xdr/operation-payout.h"
%#include "xdr/operation-create-AML-alert-request.h"
%#include "xdr/operation-manage-key-value.h"
%#include "xdr/operation-create-change-role-request.h"
%#include "xdr/operation-manage-external-system-id-pool-entry.h"
%#include "xdr/operation-bind-external-system-id.h"
%#include "xdr/operation-payment.h"
%#include "xdr/operation-manage-sale.h"
%#include "xdr/operation-create-manage-limits-request.h"
%#include "xdr/operation-manage-contract.h"
%#include "xdr/operation-manage-contract-request.h"
%#include "xdr/operation-create-atomic-swap-bid-request.h"
%#include "xdr/operation-cancel-atomic-swap-ask.h"
%#include "xdr/operation-create-atomic-swap-ask-request.h"
%#include "xdr/operation-manage-account-role.h"
%#include "xdr/operation-manage-account-rule.h"
%#include "xdr/operation-manage-signer-role.h"
%#include "xdr/operation-manage-signer-rule.h"
%#include "xdr/operation-manage-signer.h"
%#include "xdr/operation-license.h"
%#include "xdr/operation-stamp.h"
%#include "xdr/operation-manage-poll.h"
%#include "xdr/operation-manage-create-poll-request.h"
%#include "xdr/operation-manage-vote.h"
%#include "xdr/operation-manage-account-specific-rule.h"
%#include "xdr/operation-cancel-change-role-request.h"
%#include "xdr/operation-create-kyc-recovery-request.h"
%#include "xdr/operation-initiate-kyc-recovery.h"
%#include "xdr/operation-remove-asset-pair.h"
%#include "xdr/operation-issuance.h"

namespace stellar
{


//: An operation is the lowest unit of work that a transaction does
struct Operation
{
    //: sourceAccount is the account used to run the operation
    //: if not set, the runtime defaults to "sourceAccount" specified at
    //: the transaction level
    AccountID* sourceAccount;

    union switch (OperationType type)
    {
    case CREATE_ACCOUNT:
        CreateAccountOp createAccountOp;
	case DESTRUCTION:
		DestructionOp destructionOp;
	case MANAGE_BALANCE:
		ManageBalanceOp manageBalanceOp;
    case CREATE_ASSET:
        CreateAssetOp createAssetOp;
    case REVIEW_REQUEST:
		ReviewRequestOp reviewRequestOp;
	case PUT_KEY_VALUE:
	    PutKeyValueOp putKeyValueOp;
    case REMOVE_KEY_VALUE:
	    RemoveKeyValueOp removeKeyValueOp;
	case CHANGE_ACCOUNT_ROLES:
		ChangeAccountRolesOp changeAccountRolesOp;
    case PAYMENT:
        PaymentOp paymentOp;
    case CREATE_SIGNER:
        CreateSignerOp createSignerOp;
    case UPDATE_SIGNER:
        UpdateSignerOp updateSignerOp;
    case REMOVE_SIGNER:
        RemoveSignerOp removeSignerOp;
    case CREATE_ROLE:
        CreateRoleOp createRoleOp;
    case UPDATE_ROLE:
        UpdateRoleOp updateRoleOp;
    case REMOVE_ROLE:
        RemoveRoleOp removeRoleOp;
    case CREATE_RULE:
        CreateRuleOp createRuleOp;
    case UPDATE_RULE:
        UpdateRuleOp updateRuleOp;
    case REMOVE_RULE:
        RemoveRuleOp removeRuleOp;
    case CREATE_REVIEWABLE_REQUEST:
        CreateReviewableRequestOp createReviewableRequestOp;
    case UPDATE_REVIEWABLE_REQUEST:
        UpdateReviewableRequestOp updateReviewableRequestOp;
    case REMOVE_REVIEWABLE_REQUEST:
        RemoveReviewableRequestOp removeReviewableRequestOp;
    case INITIATE_KYC_RECOVERY:
        InitiateKYCRecoveryOp initiateKYCRecoveryOp;
    case KYC_RECOVERY:
        KYCRecoveryOp kycRecoveryOp;
    case ISSUANCE:
        IssuanceOp issuanceOp;
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
    //: specifies inclusive min ledger close time after which transaction is valid
    uint64 minTime;
    //: specifies inclusive max ledger close time before which transaction is valid.
    //: note: transaction will be rejected if max time exceeds close time of current ledger on more then [`tx_expiration_period`](https://tokend.gitlab.io/horizon/#operation/info)
    uint64 maxTime; // 0 here means no maxTime
};

//: Transaction is a container for a set of operations
//:    - is executed by an account
//:    - operations are executed in order as one ACID transaction
//: (either all operations are applied or none are if any returns a failing code)
struct Transaction
{
    //: account used to run the transaction
    AccountID sourceAccount;

    //: random number used to ensure there is no hash collisions
    Salt salt;

    //: validity range (inclusive) for the last ledger close time
    TimeBounds timeBounds;

    //: allows to attach additional data to the transactions
    Memo memo;

    //: list of operations to be applied. Max size is 100
    Operation operations<100>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/* A TransactionEnvelope wraps a transaction with signatures. */
struct TransactionEnvelope
{
    Transaction tx;
    //: list of signatures used to authorize transaction
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
    opBAD_AUTH_EXTRA = -8,
    opNO_ROLE_PERMISSION = -9, // not allowed for this role of source account
    opNO_ENTRY = -10,
    opNOT_SUPPORTED = -11,
    opLICENSE_VIOLATION = -12, // number of admins is greater than allowed
    //: operation was skipped cause of failure validation of previous operation
    opSKIPPED = -13
};

//: Defines requirements for tx or operation which were not fulfilled
struct RuleRequirement
{
	//: defines resources to which access was denied
    RuleResource resource;
	//: defines action which was denied
    RuleAction action;
	//: defines account for which requirements were not met
	AccountID account;

	//: reserved for future extension
    EmptyExt ext;
};

union OperationResultTr switch (OperationType type)
{
case CREATE_ACCOUNT:
    CreateAccountResult createAccountResult;
case DESTRUCTION:
    DestructionResult destructionResult;
case MANAGE_BALANCE:
    ManageBalanceResult manageBalanceResult;
case CREATE_ASSET:
    CreateAssetResult createAssetResult;
case REVIEW_REQUEST:
    ReviewRequestResult reviewRequestResult;
case PUT_KEY_VALUE:
    PutKeyValueResult putKeyValueResult;
case REMOVE_KEY_VALUE:
    RemoveKeyValueResult removeKeyValueResult;
case CHANGE_ACCOUNT_ROLES:
    ChangeAccountRolesResult changeAccountRolesResult;
case PAYMENT:
    PaymentResult paymentResult;
case CREATE_SIGNER:
    CreateSignerResult createSignerResult;
case UPDATE_SIGNER:
    UpdateSignerResult updateSignerResult;
case REMOVE_SIGNER:
    RemoveSignerResult removeSignerResult;
case CREATE_ROLE:
    CreateRoleResult createRoleResult;
case UPDATE_ROLE:
    UpdateRoleResult updateRoleResult;
case REMOVE_ROLE:
    RemoveRoleResult removeRoleResult;
case CREATE_RULE:
    CreateRuleResult createRuleResult;
case UPDATE_RULE:
    UpdateRuleResult updateRuleResult;
case REMOVE_RULE:
    RemoveRuleResult removeRuleResult;
case CREATE_REVIEWABLE_REQUEST:
    CreateReviewableRequestResult createReviewableRequestResult;
case UPDATE_REVIEWABLE_REQUEST:
    UpdateReviewableRequestResult updateReviewableRequestResult;
case REMOVE_REVIEWABLE_REQUEST:
    RemoveReviewableRequestResult removeReviewableRequestResult;
case KYC_RECOVERY:
    KYCRecoveryResult kycRecoveryResult;
case INITIATE_KYC_RECOVERY:
    InitiateKYCRecoveryResult initiateKYCRecoveryResult;
case ISSUANCE:
    IssuanceResult issuanceResult;
};

union OperationResult switch (OperationResultCode code)
{
case opINNER:
    OperationResultTr tr;
case opNO_ENTRY:
    LedgerKey entryKey;
case opNO_ROLE_PERMISSION:
case opBAD_AUTH:
    RuleRequirement requirement;
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

    txBAD_AUTH = -5,                   // too few valid signatures / wrong network
    txNO_ACCOUNT = -6,                 // source account not found
    txBAD_AUTH_EXTRA = -7,             // unused signatures attached to transaction
    txINTERNAL_ERROR = -8,             // an unknown error occurred
    txACCOUNT_BLOCKED = -9,            // account is blocked and cannot be source of tx
    txDUPLICATION = -10,               // if timing is stored
    txINSUFFICIENT_FEE = -11,          // the actual total fee amount is greater than the max total fee amount, provided by the source
    txSOURCE_UNDERFUNDED = -12,        // not enough tx fee asset on source balance
    txCOMMISSION_LINE_FULL = -13,      // commission tx fee asset balance amount overflow
    txFEE_INCORRECT_PRECISION = -14,   // fee amount is incompatible with asset precision
    txNO_ROLE_PERMISSION = -15         // account role has not rule that allows send transaction
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

struct TransactionResult
{
    int64 feeCharged; // actual fee charged for the transaction

    union switch (TransactionResultCode code)
    {
    case txSUCCESS:
    case txFAILED:
        OperationResult results<>;
    case txNO_ROLE_PERMISSION:
        RuleRequirement requirement;
    default:
        void;
    }
    result;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};
}
