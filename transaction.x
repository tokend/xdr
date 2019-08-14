// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/ledger-entries.h"
%#include "xdr/operation-create-account.h"
%#include "xdr/operation-change-public-key.h"
%#include "xdr/operation-recovery.h"
%#include "xdr/operation-put-data.h"
%#include "xdr/operation-confirm-data.h"
%#include "xdr/operation-put-identifier.h"
%#include "xdr/operation-confirm-identifier.h"

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
    case CHANGE_KEY:
        ChangeKeyOp changeKeyOp;
    case RECOVERY:
        RecoveryOp recoveryOp;
    case PUT_DATA:
        PutDataOp putDataOp;
    case CONFIRM_DATA:
        ConfirmDataOp confirmDataOp;
    case PUT_IDENTIFIER:
        PutIdentifierOp putIdentifierOp;
    case CONFIRM_IDENTIFIER:
        ConfirmIdentifierOp confirmIdentifierOp;
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
    opNO_COUNTERPARTY = -5,
    opCOUNTERPARTY_BLOCKED = -6,
    opCOUNTERPARTY_WRONG_TYPE = -7,
    opBAD_AUTH_EXTRA = -8,
    opNOT_SUPPORTED = -11,
    //: operation was skipped cause of failure validation of previous operation
    opSKIPPED = -12
};

union OperationResult switch (OperationResultCode code)
{
case opINNER:
    union switch (OperationType type)
    {
    case CREATE_ACCOUNT:
        CreateAccountResult createAccountResult;
    case RECOVERY:
        RecoveryResult recoveryResult;
	case CHANGE_KEY:
        ChangeKeyResult changeKeyResult;
    case PUT_DATA:
        PutDataResult putDataResult;
    case CONFIRM_DATA:
        ConfirmDataResult confirmDataResult;
    case PUT_IDENTIFIER:
        PutIdentifierResult putIdentifierResult;
    case CONFIRM_IDENTIFIER:
        ConfirmIdentifierResult confirmIdentifierResult;
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

    txBAD_AUTH = -5,                   // too few valid signatures / wrong network
    txNO_ACCOUNT = -6,                 // source account not found
    txBAD_AUTH_EXTRA = -7,             // unused signatures attached to transaction
    txINTERNAL_ERROR = -8,             // an unknown error occurred
    txACCOUNT_BLOCKED = -9,            // account is blocked and cannot be source of tx
    txDUPLICATION = -10               // if timing is stored
};

struct TransactionResult
{
    union switch (TransactionResultCode code)
    {
    case txSUCCESS:
    case txFAILED:
        OperationResult results<>;
    default:
        void;
    }
    result;

    //: reserved for future use
    EmptyExt ext;
};
}
