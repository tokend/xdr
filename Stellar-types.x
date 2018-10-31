// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

namespace stellar
{

typedef opaque Hash[32];
typedef opaque uint256[32];

typedef unsigned int uint32;
typedef int int32;

typedef unsigned hyper uint64;
typedef hyper int64;

enum CryptoKeyType
{
    KEY_TYPE_ED25519 = 0
};

enum PublicKeyType
{
	PUBLIC_KEY_TYPE_ED25519 = 0
};

union PublicKey switch (CryptoKeyType type)
{
case KEY_TYPE_ED25519:
    uint256 ed25519;
};

enum LedgerVersion {
	EMPTY_VERSION = 0,
	PASS_EXTERNAL_SYS_ACC_ID_IN_CREATE_ACC = 1,
	DETAILED_LEDGER_CHANGES = 2, // write more all ledger changes to transaction meta
	NEW_SIGNER_TYPES = 3, // use more comprehensive list of signer types
	TYPED_SALE = 4, // sales can have type
	UNIQUE_BALANCE_CREATION = 5, // allows to specify in manage balance that balance should not be created if one for such asset and account exists
	ASSET_PREISSUER_MIGRATION = 6,
	ASSET_PREISSUER_MIGRATED = 7,
	USE_KYC_LEVEL = 8,
	ERROR_ON_NON_ZERO_TASKS_TO_REMOVE_IN_REJECT_KYC = 9,
	ALLOW_ACCOUNT_MANAGER_TO_CHANGE_KYC = 10,
	CHANGE_ASSET_ISSUER_BAD_AUTH_EXTRA_FIXED = 11,
	AUTO_CREATE_COMMISSION_BALANCE_ON_TRANSFER = 12,
    ALLOW_REJECT_REQUEST_OF_BLOCKED_REQUESTOR = 13,
	ASSET_UPDATE_CHECK_REFERENCE_EXISTS = 14,
	CROSS_ASSET_FEE = 15,
	USE_PAYMENT_V2 = 16,
	ALLOW_SYNDICATE_TO_UPDATE_KYC = 17,
	DO_NOT_BUILD_ACCOUNT_IF_VERSION_EQUALS_OR_GREATER = 18,
	ALLOW_TO_SPECIFY_REQUIRED_BASE_ASSET_AMOUNT_FOR_HARD_CAP = 19,
	KYC_RULES = 20,
	ALLOW_TO_CREATE_SEVERAL_SALES = 21,
	KEY_VALUE_POOL_ENTRY_EXPIRES_AT = 22,
	KEY_VALUE_UPDATE = 23,
	ALLOW_TO_CANCEL_SALE_PARTICIP_WITHOUT_SPECIFING_BALANCE = 24,
	DETAILS_MAX_LENGTH_EXTENDED = 25,
	ALLOW_MASTER_TO_MANAGE_SALE = 26,
	USE_SALE_ANTE = 27,
	FIX_ASSET_PAIRS_CREATION_IN_SALE_CREATION = 28,
	STATABLE_SALES = 29,
	CREATE_ONLY_STATISTICS_V2 = 30,
	LIMITS_UPDATE_REQUEST_DEPRECATED_DOCUMENT_HASH = 31,
	FIX_PAYMENT_V2_FEE = 32,
	ADD_SALE_ID_REVIEW_REQUEST_RESULT = 33,
	FIX_SET_SALE_STATE_AND_CHECK_SALE_STATE_OPS = 34, // only master allowed to set sale state, max issuance after sale closure = pending + issued
	FIX_UPDATE_MAX_ISSUANCE = 35,
	ALLOW_CLOSE_SALE_WITH_NON_ZERO_BALANCE = 36,
	ALLOW_TO_UPDATE_VOTING_SALES_AS_PROMOTION = 37,
	ALLOW_TO_ISSUE_AFTER_SALE = 38,
	FIX_PAYMENT_V2_SEND_TO_SELF = 39,
	FIX_PAYMENT_V2_DEST_ACCOUNT_NOT_FOUND = 40,
	FIX_CREATE_KYC_REQUEST_AUTO_APPROVE = 41,
	ADD_TASKS_TO_REVIEWABLE_REQUEST = 42,
	USE_ONLY_PAYMENT_V2 = 43,
    ADD_REVIEW_INVOICE_REQUEST_PAYMENT_RESPONSE = 44,
    ADD_CONTRACT_ID_REVIEW_REQUEST_RESULT = 45,
    ALLOW_TO_UPDATE_AND_REJECT_LIMITS_UPDATE_REQUESTS = 46,
    ADD_CUSTOMER_DETAILS_TO_CONTRACT = 47,
    ADD_CAPITAL_DEPLOYMENT_FEE_TYPE = 48,
    ADD_TRANSACTION_FEE = 49,
    ADD_DEFAULT_ISSUANCE_TASKS = 50,
	ADD_ASSET_BALANCE_PRECISION = 51,
    REPLACE_ACCOUNT_TYPES_WITH_POLICIES = 999999 // do not use it yet, there are features to be improved
};

// variable size as the size depends on the signature scheme used
typedef opaque Signature<64>;

typedef opaque SignatureHint[4];

typedef PublicKey NodeID;

struct Curve25519Secret
{
        opaque key[32];
};

struct Curve25519Public
{
        opaque key[32];
};

struct HmacSha256Key
{
        opaque key[32];
};

struct HmacSha256Mac
{
        opaque mac[32];
};

typedef PublicKey AccountID;
typedef PublicKey BalanceID;
typedef opaque Thresholds[4];
typedef string string32<32>;
typedef string string64<64>;
typedef string string256<256>;
typedef string longstring<>;

typedef string AssetCode<16>;

typedef uint64 Salt;
typedef opaque DataValue<64>;

struct Fee {
	uint64 fixed;
	uint64 percent;

    // reserved for future use
    union switch(LedgerVersion v)
    {
        case EMPTY_VERSION:
            void;
    }
    ext;
};

enum OperationType
{
    CREATE_ACCOUNT = 0,
    PAYMENT = 1,
    SET_OPTIONS = 2,
    CREATE_ISSUANCE_REQUEST = 3,
    SET_FEES = 5,
	MANAGE_ACCOUNT = 6,
    CREATE_WITHDRAWAL_REQUEST = 7,
    MANAGE_BALANCE = 9,
    MANAGE_ASSET = 11,
    CREATE_PREISSUANCE_REQUEST = 12,
    MANAGE_LIMITS = 13,
    DIRECT_DEBIT = 14,
	MANAGE_ASSET_PAIR = 15,
	MANAGE_OFFER = 16,
    MANAGE_INVOICE_REQUEST = 17,
	REVIEW_REQUEST = 18,
	CREATE_SALE_REQUEST = 19,
	CHECK_SALE_STATE = 20,
    CREATE_AML_ALERT = 21,
    CREATE_KYC_REQUEST = 22,
    PAYMENT_V2 = 23,
    MANAGE_EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY = 24,
    BIND_EXTERNAL_SYSTEM_ACCOUNT_ID = 25,
    MANAGE_SALE = 26,
    MANAGE_KEY_VALUE = 27,
    CREATE_MANAGE_LIMITS_REQUEST = 28,
    MANAGE_CONTRACT_REQUEST = 29,
    MANAGE_CONTRACT = 30,
    CANCEL_SALE_REQUEST = 31,
    PAYOUT = 32,
    MANAGE_ACCOUNT_ROLE = 33,
    MANAGE_ACCOUNT_ROLE_PERMISSION = 34
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

}
