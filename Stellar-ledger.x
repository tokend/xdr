// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-transaction.h"
%#include "xdr/Stellar-types.h"

namespace stellar
{

enum ExternalSystemIDGeneratorType {
	BITCOIN_BASIC = 1,
	ETHEREUM_BASIC = 2
};

typedef opaque UpgradeType<128>;

/* StellarValue is the value used by SCP to reach consensus on a given ledger
*/
struct StellarValue
{
    Hash txSetHash;   // transaction set to apply to previous ledger
    uint64 closeTime; // network close time

    // upgrades to apply to the previous ledger (usually empty)
    // this is a vector of encoded 'LedgerUpgrade' so that nodes can drop
    // unknown steps during consensus if needed.
    // see notes below on 'LedgerUpgrade' for more detail
    // max size is dictated by number of upgrade types (+ room for future)
    UpgradeType upgrades<6>;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

// The IdGenerator is generator of id for specific instances
struct IdGenerator {
	LedgerEntryType entryType; // type of the entry, for which ids will be generated
	uint64 idPool; // last used entry specific ID, used for generating entry of specified type
};

/* The LedgerHeader is the highest level structure representing the
 * state of a ledger, cryptographically linked to previous ledgers.
*/
struct LedgerHeader
{
    uint32 ledgerVersion;    // the protocol version of the ledger
    Hash previousLedgerHash; // hash of the previous ledger header
    StellarValue scpValue;   // what consensus agreed to
    Hash txSetResultHash;    // the TransactionResultSet that led to this ledger
    Hash bucketListHash;     // hash of the ledger state

    uint32 ledgerSeq; // sequence number of this ledger

    IdGenerator idGenerators<>; // generators of ids

    uint32 baseFee;     // base fee per operation in stroops
    uint32 baseReserve; // account base reserve in stroops

    uint32 maxTxSetSize; // maximum size a transaction set can be

    ExternalSystemIDGeneratorType externalSystemIDGenerators<>;
    int64 txExpirationPeriod;
    
    Hash skipList[4]; // hashes of ledgers in the past. allows you to jump back
                      // in time without walking the chain back ledger by ledger
                      // each slot contains the oldest ledger that is mod of
                      // either 50  5000  50000 or 500000 depending on index
                      // skipList[0] mod(50), skipList[1] mod(5000), etc

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/* Ledger upgrades
note that the `upgrades` field from StellarValue is normalized such that
it only contains one entry per LedgerUpgradeType, and entries are sorted
in ascending order
*/
enum LedgerUpgradeType
{
    VERSION = 1,
    MAX_TX_SET_SIZE = 2,
    TX_EXPIRATION_PERIOD = 3,
	EXTERNAL_SYSTEM_ID_GENERATOR = 4
};

union LedgerUpgrade switch (LedgerUpgradeType type)
{
case VERSION:
    uint32 newLedgerVersion; // update ledgerVersion
case MAX_TX_SET_SIZE:
    uint32 newMaxTxSetSize; // update maxTxSetSize
case EXTERNAL_SYSTEM_ID_GENERATOR:
    ExternalSystemIDGeneratorType newExternalSystemIDGenerators<>;
case TX_EXPIRATION_PERIOD:
    int64 newTxExpirationPeriod;
};

/* Entries used to define the bucket list */

union LedgerKey switch (LedgerEntryType type)
{
case ACCOUNT:
    struct
    {
        AccountID accountID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } account;
case FEE:
    struct {
        Hash hash;
		int64 lowerBound;
		int64 upperBound;
		 union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } feeState;
case BALANCE:
    struct
    {
		BalanceID balanceID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } balance;
case PAYMENT_REQUEST:
    struct
    {
		uint64 paymentID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } paymentRequest;
case ASSET:
    struct
    {
		AssetCode code;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } asset;
case REFERENCE_ENTRY:
    struct
    {
		AccountID sender;
		string64 reference;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } reference;
case ACCOUNT_TYPE_LIMITS:
    struct {
        AccountType accountType;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } accountTypeLimits;
case STATISTICS:
    struct {
        AccountID accountID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } stats;
case TRUST:
    struct {
        AccountID allowedAccount;
        BalanceID balanceToUse;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } trust;
case ACCOUNT_LIMITS:
    struct {
        AccountID accountID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } accountLimits;
case ASSET_PAIR:
	struct {
         AssetCode base;
		 AssetCode quote;
		 union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } assetPair;
case OFFER_ENTRY:
	struct {
		uint64 offerID;
		AccountID ownerID;
	} offer;
case INVOICE:
    struct {
        uint64 invoiceID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } invoice;
case REVIEWABLE_REQUEST:
    struct {
        uint64 requestID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
    } reviewableRequest;
case EXTERNAL_SYSTEM_ACCOUNT_ID:
	struct {
		AccountID accountID;
		int32 externalSystemType;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} externalSystemAccountID;
case SALE:
	struct {
		uint64 saleID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} sale;
case ACCOUNT_KYC:
    struct {
        AccountID accountID;
        union switch(LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } accountKYC;
case EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY:
    struct {
		uint64 poolEntryID;
		union switch (LedgerVersion v)
		{
		case EMPTY_VERSION:
			void;
		}
		ext;
	} externalSystemAccountIDPoolEntry;
};

enum BucketEntryType
{
    LIVEENTRY = 0,
    DEADENTRY = 1
};

union BucketEntry switch (BucketEntryType type)
{
case LIVEENTRY:
    LedgerEntry liveEntry;

case DEADENTRY:
    LedgerKey deadEntry;
};

// Transaction sets are the unit used by SCP to decide on transitions
// between ledgers
struct TransactionSet
{
    Hash previousLedgerHash;
    TransactionEnvelope txs<>;
};

struct TransactionResultPair
{
    Hash transactionHash;
    TransactionResult result; // result for the transaction
};

// TransactionResultSet is used to recover results between ledgers
struct TransactionResultSet
{
    TransactionResultPair results<>;
};

// Entries below are used in the historical subsystem

struct TransactionHistoryEntry
{
    uint32 ledgerSeq;
    TransactionSet txSet;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct TransactionHistoryResultEntry
{
    uint32 ledgerSeq;
    TransactionResultSet txResultSet;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct LedgerHeaderHistoryEntry
{
    Hash hash;
    LedgerHeader header;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

// historical SCP messages

struct LedgerSCPMessages
{
    uint32 ledgerSeq;
    SCPEnvelope messages<>;
};

// note: ledgerMessages may refer to any quorumSets encountered
// in the file so far, not just the one from this entry
struct SCPHistoryEntryV0
{
    SCPQuorumSet quorumSets<>; // additional quorum sets used by ledgerMessages
    LedgerSCPMessages ledgerMessages;
};

// SCP history file is an array of these
union SCPHistoryEntry switch (LedgerVersion v)
{
case EMPTY_VERSION:
    SCPHistoryEntryV0 v0;
};

// represents the meta in the transaction table history

// STATE is emitted every time a ledger entry is modified/deleted
// and the entry was not already modified in the current ledger

enum LedgerEntryChangeType
{
    CREATED = 0, // entry was added to the ledger
    UPDATED = 1, // entry was modified in the ledger
    REMOVED = 2, // entry was removed from the ledger
    STATE = 3    // value of the entry
};

union LedgerEntryChange switch (LedgerEntryChangeType type)
{
case CREATED:
    LedgerEntry created;
case UPDATED:
    LedgerEntry updated;
case REMOVED:
    LedgerKey removed;
case STATE:
    LedgerEntry state;
};

typedef LedgerEntryChange LedgerEntryChanges<>;

struct OperationMeta
{
    LedgerEntryChanges changes;
};

union TransactionMeta switch (LedgerVersion v)
{
case EMPTY_VERSION:
    OperationMeta operations<>;
};
}
