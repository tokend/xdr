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
    ACCOUNT = 1,
    SIGNER = 2,
    BALANCE = 3,
    DATA = 4,
    ASSET = 5,
    REFERENCE = 6,
    REVIEWABLE_REQUEST = 7,
	ACCOUNT_KYC = 8,
    KEY_VALUE = 9,
    RULE = 10,
    ROLE = 11
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
    PUT_KEY_VALUE = 2,
    REMOVE_KEY_VALUE = 3,
    CREATE_ASSET = 4,
    UPDATE_ASSET = 5,
    PAYMENT = 6,
    ISSUANCE = 7,
    DESTRUCTION = 8,
    CREATE_BALANCE = 9,
    CREATE_DATA = 10,
    UPDATE_DATA = 11,
    REMOVE_DATA = 12,
    REVIEW_REQUEST = 13,
	CHANGE_ACCOUNT_ROLES = 14,
    CREATE_SIGNER = 15,
    UPDATE_SIGNER = 16,
    REMOVE_SIGNER = 17,
    CREATE_ROLE = 18,
    UPDATE_ROLE = 19,
    REMOVE_ROLE = 20,
    CREATE_RULE = 21,
    UPDATE_RULE = 22,
    REMOVE_RULE = 23,
    CREATE_REVIEWABLE_REQUEST = 24,
    UPDATE_REVIEWABLE_REQUEST = 25,
    REMOVE_REVIEWABLE_REQUEST = 26,
    INITIATE_KYC_RECOVERY = 27,
    KYC_RECOVERY = 28
};

struct DecoratedSignature
{
    SignatureHint hint;  // last 4 bytes of the public key, used as a hint
    Signature signature; // actual signature
};


//: Defines the type of destination for operation
enum DestinationType {
    ACCOUNT = 0,
    BALANCE = 1
};

union MovementDestination switch (DestinationType type) {
    case ACCOUNT:
        AccountID accountID;
    case BALANCE:
        BalanceID balanceID;
};

}
