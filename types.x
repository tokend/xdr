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
    CLEAR_DATABASE_CACHE = 20
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
	ACCOUNT_KYC = 18,
    KEY_VALUE = 20,
    DATA = 21,
    ACCOUNT_ROLE = 26,
    ACCOUNT_RULE = 27,
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
    CHANGE_ROLE = 2,
    UPDATE_DATA = 8,
    REMOVE_DATA = 10,
    CREATE_DATA = 14,
    MANAGE_KEY_VALUE = 27,
    MANAGE_ACCOUNT_ROLE = 33,
    MANAGE_ACCOUNT_RULE = 34,
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
