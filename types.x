// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

namespace stellar
{

enum LedgerVersion
{
    EMPTY_VERSION = 0
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
    ACCOUNT_LIMITS = 10,
	ASSET_PAIR = 11,
	OFFER_ENTRY = 12,
	REVIEWABLE_REQUEST = 13,
	EXTERNAL_SYSTEM_ACCOUNT_ID = 14,
	SALE = 15,
	ACCOUNT_KYC = 16,
	EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY = 17,
    KEY_VALUE = 18,
    LIMITS_V2 = 19,
    STATISTICS_V2 = 20,
    PENDING_STATISTICS = 21,
    CONTRACT = 22,
    ACCOUNT_ROLE = 23,
    ACCOUNT_RULE = 24,
    ATOMIC_SWAP_ASK = 25,
    TRANSACTION = 26, // is used for account rule resource
    SIGNER_RULE = 27,
    SIGNER_ROLE = 28,
    STAMP = 29,
    LICENSE = 30,
    POLL = 31,
    VOTE = 32,
    ACCOUNT_SPECIFIC_RULE = 33
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
    CREATE_ISSUANCE_REQUEST = 1,
    SET_FEES = 2,
    CREATE_WITHDRAWAL_REQUEST = 3,
    MANAGE_BALANCE = 4,
    MANAGE_ASSET = 5,
    CREATE_PREISSUANCE_REQUEST = 6,
    MANAGE_LIMITS = 7,
	MANAGE_ASSET_PAIR = 8,
	MANAGE_OFFER = 9,
    MANAGE_INVOICE_REQUEST = 10,
	REVIEW_REQUEST = 11,
	CREATE_SALE_REQUEST = 12,
	CHECK_SALE_STATE = 13,
    CREATE_AML_ALERT = 14,
    CREATE_CHANGE_ROLE_REQUEST = 15,
    PAYMENT = 16,
    MANAGE_EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY = 17,
    BIND_EXTERNAL_SYSTEM_ACCOUNT_ID = 18,
    MANAGE_SALE = 19,
    MANAGE_KEY_VALUE = 20,
    CREATE_MANAGE_LIMITS_REQUEST = 21,
    MANAGE_CONTRACT_REQUEST = 22,
    MANAGE_CONTRACT = 23,
    CANCEL_SALE_REQUEST = 24,
    PAYOUT = 25,
    MANAGE_ACCOUNT_ROLE = 26,
    MANAGE_ACCOUNT_RULE = 27,
    CREATE_ATOMIC_SWAP_ASK_REQUEST = 28,
    CANCEL_ATOMIC_SWAP_ASK = 29,
    CREATE_ATOMIC_SWAP_BID_REQUEST = 30,
    MANAGE_SIGNER = 31,
    MANAGE_SIGNER_ROLE = 32,
    MANAGE_SIGNER_RULE = 33,
    STAMP = 34,
    LICENSE = 35,
    MANAGE_CREATE_POLL_REQUEST = 36,
    MANAGE_POLL = 37,
    MANAGE_VOTE = 38,
    MANAGE_ACCOUNT_SPECIFIC_RULE = 39,
    CANCEL_CHANGE_ROLE_REQUEST = 40,
    REMOVE_ASSET_PAIR = 41
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

enum AccessDefinitionType
{
    NONE = 1,
    WHITELIST = 2,
    BLACKLIST = 3
};

}
