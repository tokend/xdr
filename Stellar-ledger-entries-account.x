// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"

namespace stellar
{

enum SignerType
{
	READER = 1,                  // can only read data from API and Horizon
	NOT_VERIFIED_ACC_MANAGER = 2,// can manage not verified account and block/unblock general
	GENERAL_ACC_MANAGER = 4,     // allowed to create account, block/unblock, change limits for particular general account
	DIRECT_DEBIT_OPERATOR = 8, // allowed to perform direct debit operation
	ASSET_MANAGER = 16, // allowed to create assets/asset pairs and update policies, set fees
	ASSET_RATE_MANAGER = 32, // allowed to set physical asset price
	BALANCE_MANAGER = 64, // allowed to create balances, spend assets from balances
	ISSUANCE_MANAGER = 128, // allowed to make preissuance request
	INVOICE_MANAGER = 256, // allowed to create payment requests to other accounts
	PAYMENT_OPERATOR = 512, // allowed to review payment requests
	LIMITS_MANAGER = 1024, // allowed to change limits
	ACCOUNT_MANAGER = 2048, // allowed to add/delete signers and trust
	COMMISSION_BALANCE_MANAGER  = 4096,// allowed to spend from commission balances
	OPERATIONAL_BALANCE_MANAGER = 8192, // allowed to spend from operational balances
	EVENTS_CHECKER = 16384, // allow to check and trigger events
	EXCHANGE_ACC_MANAGER = 32768, // can manage exchange account
	SYNDICATE_ACC_MANAGER = 65536, // can manage syndicate account
	USER_ASSET_MANAGER = 131072, // can review sale, asset creation/update requests
	USER_ISSUANCE_MANAGER = 262144, // can review pre-issuance/issuance requests
	WITHDRAW_MANAGER = 524288, // can review withdraw requests
	FEES_MANAGER = 1048576, // can set fee
	TX_SENDER = 2097152, // can send tx
    AML_ALERT_MANAGER = 4194304, // can manage AML alert request
    AML_ALERT_REVIEWER = 8388608, // can review aml alert requests
	KYC_ACC_MANAGER = 16777216, // can manage kyc
	KYC_SUPER_ADMIN = 33554432
};

struct Signer
{
    AccountID pubKey;
    uint32 weight; // really only need 1byte
	uint32 signerType;
	uint32 identity;
	string256 name;

	 // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
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
	SYNDICATE = 6, // can create asset
	EXCHANGE = 7
};

enum BlockReasons
{
	RECOVERY_REQUEST = 1,
	KYC_UPDATE = 2,
	SUSPICIOUS_BEHAVIOR = 4,
	TOO_MANY_KYC_UPDATE_REQUESTS = 8
};


/* AccountEntry

    Main entry representing a user in Stellar. All transactions are
    performed using an account.

    Other ledger entries created require an account.

*/

struct AccountEntry
{
    AccountID accountID;      // master public key for this account
    AccountID recoveryID;

    // fields used for signatures
    // thresholds stores unsigned bytes: [weight of master|low|medium|high]
    Thresholds thresholds;

    Signer signers<>; // possible signers for this account
    Limits* limits;

	uint32 blockReasons;
    AccountType accountType; // type of the account
    
    // Referral marketing
    AccountID* referrer;     // parent account

	int32 policies;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	case USE_KYC_LEVEL:
		uint32 kycLevel;
    }
	
    ext;
};

}
