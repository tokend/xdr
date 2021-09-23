// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

namespace stellar
{

enum LedgerVersion
{
    EMPTY_VERSION = 0,
    CHECK_SET_FEE_ACCOUNT_EXISTING = 1,
    FIX_PAYMENT_STATS = 2,
    ADD_INVEST_FEE = 3,
    ADD_SALE_WHITELISTS = 4,
    ASSET_PAIR_RESTRICTIONS = 5,
    FIX_CHANGE_TO_NON_EXISTING_ROLE = 6,
    FIX_REVERSE_SALE_PAIR = 7,
    FIX_NOT_CHECKING_SET_TASKS_PERMISSIONS = 8,
    UNLIMITED_ADMIN_COUNT = 9,
    FIX_AML_ALERT_ERROR_CODES = 10,
    FIX_EXT_SYS_ACC_EXPIRATION_TIME = 11,
    FIX_CHANGE_ROLE_REJECT_TASKS = 12,
    FIX_SAME_ASSET_PAIR = 13,
    ATOMIC_SWAP_RETURNING = 14,
    FIX_INVEST_FEE = 15,
    ADD_ACC_SPECIFIC_RULE_RESOURCE = 16,
    FIX_SIGNER_CHANGES_REMOVE = 17,
    FIX_DEPOSIT_STATS = 18,
    FIX_CREATE_KYC_RECOVERY_PERMISSIONS = 19,
    CLEAR_DATABASE_CACHE = 20,
    FIX_ISSUANCE_REVIEWER = 21,
    MARK_ASSET_AS_DELETED = 22,
    FIX_MAX_SUBJECT_SIZE = 23,
    FIX_MOVEMENT_REVIEW = 24,
    FIX_SIGNATURE_CHECK = 25,
    FIX_AUTOREVIEW = 26,
    MOVEMENT_REQUESTS_DETAILS = 27,
    FIX_CRASH_CORE_WITH_PAYMENT = 28,
    FIX_INVEST_TO_IMMEDIATE_SALE = 29,
    FIX_PAYMENT_TASKS_WILDCARD_VALUE = 30,
    FIX_CHANGE_ROLE_REQUEST_REQUESTOR = 31,
    FIX_UNORDERED_FEE_DESTINATION = 32,
    ADD_DEFAULT_FEE_RECEIVER_BALANCE_KV = 33,
    DELETE_REDEMPTION_ZERO_TASKS_CHECKING = 34
};

union EmptyExt switch (LedgerVersion v)
{
case EMPTY_VERSION:
    void;
};

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


enum LedgerEntryType
{
    ANY = 1,
    ACCOUNT = 2,
    SIGNER = 3,
    FEE = 4,
    BALANCE = 5,
    PAYMENT_REQUEST = 6,
    ASSET = 7,
    REFERENCE_ENTRY = 8,
    STATISTICS = 9,
    TRUST = 10,
    ACCOUNT_LIMITS = 11,
	ASSET_PAIR = 12,
	OFFER_ENTRY = 13,
	REVIEWABLE_REQUEST = 15,
	EXTERNAL_SYSTEM_ACCOUNT_ID = 16,
	SALE = 17,
	ACCOUNT_KYC = 18,
	EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY = 19,
    KEY_VALUE = 20,
    LIMITS_V2 = 22,
    STATISTICS_V2 = 23,
    PENDING_STATISTICS = 24,
    CONTRACT = 25,
    ACCOUNT_ROLE = 26,
    ACCOUNT_RULE = 27,
    ATOMIC_SWAP_ASK = 28,
    TRANSACTION = 29, // is used for account rule resource
    SIGNER_RULE = 30,
    SIGNER_ROLE = 31,
    STAMP = 32,
    LICENSE = 33,
    POLL = 34,
    VOTE = 35,
    ACCOUNT_SPECIFIC_RULE = 36,
    INITIATE_KYC_RECOVERY = 37,
    SWAP = 38,
    DATA = 39,
    CUSTOM = 40,
    DEFERRED_PAYMENT = 41
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

//: `Fee` is used to unite fixed and percent fee amounts
struct Fee {
    //: Fixed amount to pay for the operation
	uint64 fixed;
	//: Part of the managed amount in percents
	uint64 percent;

    //: reserved for future use
    union switch(LedgerVersion v)
    {
        case EMPTY_VERSION:
            void;
    }
    ext;
};

enum OperationType
{
    CREATE_ACCOUNT = 1,
    CREATE_ISSUANCE_REQUEST = 3,
    SET_FEES = 5,
    CREATE_WITHDRAWAL_REQUEST = 7,
    MANAGE_BALANCE = 9,
    MANAGE_ASSET = 11,
    CREATE_PREISSUANCE_REQUEST = 12,
    MANAGE_LIMITS = 13,
	MANAGE_ASSET_PAIR = 15,
	MANAGE_OFFER = 16,
    MANAGE_INVOICE_REQUEST = 17,
	REVIEW_REQUEST = 18,
	CREATE_SALE_REQUEST = 19,
	CHECK_SALE_STATE = 20,
    CREATE_AML_ALERT = 21,
    CREATE_CHANGE_ROLE_REQUEST = 22,
    PAYMENT = 23,
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
    MANAGE_ACCOUNT_RULE = 34,
    CREATE_ATOMIC_SWAP_ASK_REQUEST = 35,
    CANCEL_ATOMIC_SWAP_ASK = 36,
    CREATE_ATOMIC_SWAP_BID_REQUEST = 37,
    MANAGE_SIGNER = 38,
    MANAGE_SIGNER_ROLE = 39,
    MANAGE_SIGNER_RULE = 40,
    STAMP = 41,
    LICENSE = 42,
    MANAGE_CREATE_POLL_REQUEST = 43,
    MANAGE_POLL = 44,
    MANAGE_VOTE = 45,
    MANAGE_ACCOUNT_SPECIFIC_RULE = 46,
    CANCEL_CHANGE_ROLE_REQUEST = 47,
    INITIATE_KYC_RECOVERY = 48,
    CREATE_KYC_RECOVERY_REQUEST = 49,
    REMOVE_ASSET_PAIR = 50,
    CREATE_MANAGE_OFFER_REQUEST = 51,
    CREATE_PAYMENT_REQUEST = 52,
    REMOVE_ASSET = 53,
    OPEN_SWAP = 54,
    CLOSE_SWAP = 55,
    CREATE_REDEMPTION_REQUEST = 56,
    CREATE_DATA = 57,
    UPDATE_DATA = 58,
    REMOVE_DATA = 59,
    CREATE_DATA_CREATION_REQUEST = 60,
    CANCEL_DATA_CREATION_REQUEST = 61,
    CREATE_DATA_UPDATE_REQUEST = 62,
    CREATE_DATA_REMOVE_REQUEST = 63,
    CANCEL_DATA_UPDATE_REQUEST = 64,
    CANCEL_DATA_REMOVE_REQUEST = 65,
    CREATE_DEFERRED_PAYMENT_CREATION_REQUEST = 66,
    CANCEL_DEFERRED_PAYMENT_CREATION_REQUEST = 67,
    CREATE_CLOSE_DEFERRED_PAYMENT_REQUEST = 68,
    CANCEL_CLOSE_DEFERRED_PAYMENT_REQUEST = 69
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

}
