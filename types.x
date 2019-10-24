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
    TRANSACTION = 0, // is used for account rule resource
    ANY = 1, // is used for rules
    ACCOUNT = 2,
    SIGNER = 3,
    BALANCE = 5,
    ASSET = 7,
    REFERENCE_ENTRY = 8,
    REVIEWABLE_REQUEST = 15,
	ACCOUNT_KYC = 18,
    KEY_VALUE = 20,
    RULE = 30,
    ROLE = 31,
    INITIATE_KYC_RECOVERY = 37,
    PAYMENT = 38,
    ISSUANCE = 39
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
    ISSUANCE = 3,
    CREATE_WITHDRAWAL_REQUEST = 7,
    MANAGE_BALANCE = 9,
    MANAGE_ASSET = 11,
    REVIEW_REQUEST = 18,
	CREATE_CHANGE_ROLE_REQUEST = 22,
    PAYMENT = 23,
    MANAGE_KEY_VALUE = 27,
    CREATE_SIGNER = 30,
    UPDATE_SIGNER = 31,
    REMOVE_SIGNER = 32,
    CREATE_ROLE = 39,
    UPDATE_ROLE = 40,
    REMOVE_ROLE = 41,
    CREATE_RULE = 42,
    UPDATE_RULE = 43,
    REMOVE_RULE = 44,
    CREATE_REVIEWABLE_REQUEST = 45,
    INITIATE_KYC_RECOVERY = 48,
    CREATE_KYC_RECOVERY_REQUEST = 49
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
