// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/transaction.h"
%#include "xdr/ledger-keys.h"

namespace stellar
{

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
    Hash txSetHash;          // hash of transactions' hashes
    Hash txSetResultHash;    // the TransactionResultSet that led to this ledger

    uint32 ledgerSeq; // sequence number of this ledger

    IdGenerator idGenerators<>; // generators of ids

    uint32 maxTxSetSize; // maximum size a transaction set can be

    uint64 txExpirationPeriod;

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
    TX_EXPIRATION_PERIOD = 3
};

union LedgerUpgrade switch (LedgerUpgradeType type)
{
case VERSION:
    uint32 newLedgerVersion; // update ledgerVersion
case MAX_TX_SET_SIZE:
    uint32 newMaxTxSetSize; // update maxTxSetSize
case TX_EXPIRATION_PERIOD:
    uint64 newTxExpirationPeriod;
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
