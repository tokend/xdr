// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum SignerType
{
	SIGNER_READER = 1,                  // can only read data from API and Horizon
	SIGNER_NOT_VERIFIED_ACC_MANAGER = 2,// can manage not verified account and block/unblock general
	SIGNER_GENERAL_ACC_MANAGER = 4,     // allowed to create account, block/unblock, change limits for particular general account
	SIGNER_DIRECT_DEBIT_OPERATOR = 8, // allowed to perform direct debit operation
	SIGNER_ASSET_MANAGER = 16, // allowed to create assets/asset pairs and update policies, set fees, review pre-issuance requests
	SIGNER_ASSET_RATE_MANAGER = 32, // allowed to set physical asset price
	SIGNER_BALANCE_MANAGER = 64, // allowed to create balances, spend assets from balances
	SIGNER_ISSUANCE_MANAGER = 128, // allowed to make preissuance request, review issuance requests
	SIGNER_INVOICE_MANAGER = 256, // allowed to create payment requests to other accounts
	SIGNER_PAYMENT_OPERATOR = 512, // allowed to review payment requests
	SIGNER_LIMITS_MANAGER = 1024, // allowed to change limits
	SIGNER_ACCOUNT_MANAGER = 2048, // allowed to add/delete signers and trust
	SIGNER_COMMISSION_BALANCE_MANAGER  = 4096,// allowed to spend from commission balances
	SIGNER_OPERATIONAL_BALANCE_MANAGER = 8192 // allowed to spend from operational balances
};

struct Signer
{
    AccountID pubKey;
    uint32 weight; // really only need 1byte
	uint32 signerType;
	uint32 identity;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	case SIGNER_NAME:
		string256 name;
    }
    ext;
};

struct TrustEntry
{
    AccountID allowedAccount;
    BalanceID balanceToUse;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};


struct Limits
{
    int64 dailyOut;
	int64 weeklyOut;
	int64 monthlyOut;
    int64 annualOut;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
    
};

enum AccountPolicies
{
	NO_PERMISSIONS = 0,
	ALLOW_TO_CREATE_USER_VIA_API = 1
};

enum AccountType
{
	OPERATIONAL = 1,       // operational account of the system 
	GENERAL = 2,           // general account can perform payments, setoptions, be source account for tx, etc.
	COMMISSION = 3,        // commission account
	MASTER = 4,            // master account
    NOT_VERIFIED = 5,
	SYNDICATE = 6 // can create asset
};

enum BlockReasons
{
	RECOVERY_REQUEST = 1,
	KYC_UPDATE = 2,
	SUSPICIOUS_BEHAVIOR = 4
};


/* AccountEntry

    Main entry representing a user in Stellar. All transactions are
    performed using an account.

    Other ledger entries created require an account.

*/

struct AccountEntry
{
    AccountID accountID;      // master public key for this account

    // fields used for signatures
    // thresholds stores unsigned bytes: [weight of master|low|medium|high]
    Thresholds thresholds;

    Signer signers<>; // possible signers for this account
    Limits* limits;

	uint32 blockReasons;
    AccountType accountType; // type of the account
    
    // Referral marketing
    AccountID* referrer;     // parent account
    int64 shareForReferrer; // share of fee to pay parent

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	case ACCOUNT_POLICIES:
		int32 policies;
    }
    ext;
};

}
