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
    ADD_CUSTOMER_DETAILS_TO_CONTRACT = 47,
    ADD_CAPITAL_DEPLOYMENT_FEE_TYPE = 48,
    ADD_TRANSACTION_FEE = 49,
    ADD_DEFAULT_ISSUANCE_TASKS = 50,
    EXTEND_REVIEW_ATOMIC_SWAP_REQUEST_RESULT = 51,
	WITHDRAWAL_TASKS = 52,
	ADD_ASSET_BALANCE_PRECISION = 53,
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
    MANAGE_ACCOUNT_ROLE_PERMISSION = 34,
    CREATE_ASWAP_BID_REQUEST = 35,
    CANCEL_ASWAP_BID = 36,
    CREATE_ASWAP_REQUEST = 37
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

}
