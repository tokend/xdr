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
    DO_NOT_BUILD_ACCOUNT_IF_VERSION_EQUALS_OR_GREATER = 13
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
    REVIEW_PAYMENT_REQUEST = 10,
    MANAGE_ASSET = 11,
    CREATE_PREISSUANCE_REQUEST = 12,
    SET_LIMITS = 13,
    DIRECT_DEBIT = 14,
	MANAGE_ASSET_PAIR = 15,
	MANAGE_OFFER = 16,
    MANAGE_INVOICE = 17,
	REVIEW_REQUEST = 18,
	CREATE_SALE_REQUEST = 19,
	CHECK_SALE_STATE = 20,
    CREATE_AML_ALERT = 21,
    CREATE_KYC_REQUEST = 22,
	MANAGE_EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY = 23,
	BIND_EXTERNAL_SYSTEM_ACCOUNT_ID = 24
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

}
