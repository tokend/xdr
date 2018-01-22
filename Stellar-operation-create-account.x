// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* CreateAccount
Creates and funds a new account with the specified starting balance.

Threshold: med

Result: CreateAccountResult

*/

struct CreateAccountOp
{
    AccountID destination; // account to create
    AccountID recoveryKey; // recovery signer's public key
    AccountID* referrer;     // parent account
	AccountType accountType;
	uint32 policies;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;	
	case PASS_EXTERNAL_SYS_ACC_ID_IN_CREATE_ACC:
		ExternalSystemAccountID externalSystemIDs<>;
    }
    ext;
};

/******* CreateAccount Result ********/

enum CreateAccountResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0, // account was created

    // codes considered as "failure" for the operation
    MALFORMED = -1,       // invalid destination
	ACCOUNT_TYPE_MISMATCHED = -2, // account already exist and change of account type is not allowed
	TYPE_NOT_ALLOWED = -3, // master or commission account types are not allowed
    NAME_DUPLICATION = -4,
    REFERRER_NOT_FOUND = -5,
	INVALID_ACCOUNT_VERSION = -6, // if account version is higher than ledger version
	NOT_VERIFIED_CANNOT_HAVE_POLICIES = -7,
	EXTERNAL_SYS_ACC_NOT_ALLOWED = -8, // op contains external system account ID which should be generated on core level
	EXTERNAL_SYS_ID_EXISTS = -9 // external system account ID already exists
};

struct CreateAccountSuccess
{
	ExternalSystemAccountID externalSystemIDs<>;
	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

union CreateAccountResult switch (CreateAccountResultCode code)
{
case SUCCESS:
    CreateAccountSuccess success;
default:
    void;
};

}
