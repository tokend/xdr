%#include "xdr/types.h"

namespace stellar
{

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
case SIGNER:
    struct
    {
        PublicKey pubKey;
        AccountID accountID;

        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } signer;
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
case KEY_VALUE:
    struct {
        longstring key;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } keyValue;
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
case LIMITS_V2:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } limitsV2;
case STATISTICS_V2:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } statisticsV2;
case PENDING_STATISTICS:
    struct {
        uint64 statisticsID;
        uint64 requestID;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } pendingStatistics;
case CONTRACT:
    struct {
        uint64 contractID;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } contract;
case ATOMIC_SWAP_ASK:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } atomicSwapAsk;
case ACCOUNT_ROLE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } accountRole;
case ACCOUNT_RULE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } accountRule;
case SIGNER_ROLE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } signerRole;
case SIGNER_RULE:
    struct {
        uint64 id;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } signerRule;
case STAMP:
    struct {
        Hash ledgerHash;
        Hash licenseHash;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        }
        ext;
    } stamp;
case LICENSE:
    struct {
        Hash licenseHash;
        union switch (LedgerVersion v)
        {
        case EMPTY_VERSION:
            void;
        } ext;
    } license;
case POLL:
    struct {
        uint64 id;

        EmptyExt ext;
    } poll;
case VOTE:
    struct {
        uint64 pollID;
        AccountID voterID;

        EmptyExt ext;
    } vote;
case ACCOUNT_SPECIFIC_RULE:
    struct {
        uint64 id;

        EmptyExt ext;
    } accountSpecificRule;
case SWAP:
    struct
    {
        uint64 id;

        EmptyExt ext;
    } swap;
case DATA:
    struct {
        uint64 id;

        EmptyExt ext;
    } data;
case DEFERRED_PAYMENT:
    struct {
        uint64 id;

        EmptyExt ext;
    } deferredPayment;
};
}