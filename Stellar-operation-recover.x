// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-ledger-entries.h"

namespace stellar
{

/* RecoverOp

    Threshold: medium

    Result: RecoverResult
*/
struct RecoverOp
{
    AccountID account;
    PublicKey oldSigner;
    PublicKey newSigner;
	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* Recover Result ********/

enum RecoverResultCode
{
    // codes considered as "success" for the operation
    SUCCESS = 0,

    // codes considered as "failure" for the operation

    MALFORMED = -1,
    OLD_SIGNER_NOT_FOUND = -2,
    SIGNER_ALREADY_EXISTS = -3
};

union RecoverResult switch (RecoverResultCode code)
{
case SUCCESS:
    struct {
		// reserved for future use
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} success;
default:
    void;
};

}
