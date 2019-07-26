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
    REFERENCE_ENTRY = 4,
	REVIEWABLE_REQUEST = 5,
	ACCOUNT_KYC = 6,
    KEY_VALUE = 7,
    ACCOUNT_ROLE = 8,
    ACCOUNT_RULE = 9,
    TRANSACTION = 10, // is used for account rule resource
    SIGNER_RULE = 11,
    SIGNER_ROLE = 12,
    INITIATE_KYC_RECOVERY = 13
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
typedef opaque Thresholds[4];
typedef string string32<32>;
typedef string string64<64>;
typedef string string256<256>;
typedef string longstring<>;

typedef uint64 Salt;
typedef opaque DataValue<64>;


enum OperationType
{
    CREATE_ACCOUNT = 1,
	REVIEW_REQUEST = 2,
    CREATE_CHANGE_ROLE_REQUEST = 3,
    CANCEL_CHANGE_ROLE_REQUEST = 4,
    MANAGE_KEY_VALUE = 5,
    MANAGE_ACCOUNT_ROLE = 6,
    MANAGE_ACCOUNT_RULE = 7,
    MANAGE_SIGNER = 8,
    MANAGE_SIGNER_ROLE = 9,
    MANAGE_SIGNER_RULE = 10,
    INITIATE_KYC_RECOVERY = 11,
    CREATE_KYC_RECOVERY_REQUEST = 12
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};

}
