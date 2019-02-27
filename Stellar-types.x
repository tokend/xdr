// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

namespace stellar
{

enum LedgerVersion {
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
    ATOMIC_SWAP_BID = 28,
    TRANSACTION = 29, // is used for account rule resource
    SIGNER_RULE = 30,
    SIGNER_ROLE = 31,
    STAMP = 32,
    LICENSE = 33
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

//: `Fee` represents the most basic Fee details such as fixed fee and charged percent of the transfer
struct Fee {
    //: Fixed amount to pay for the operation
	uint64 fixed;
	//: Percent of transfer amount to be charged
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
    CREATE_ASWAP_BID_REQUEST = 35,
    CANCEL_ASWAP_BID = 36,
    CREATE_ASWAP_REQUEST = 37,
    MANAGE_SIGNER = 38,
    MANAGE_SIGNER_ROLE = 39,
    MANAGE_SIGNER_RULE = 40,
    STAMP = 41,
    LICENSE = 42
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

}
