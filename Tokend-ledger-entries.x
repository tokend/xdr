// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Tokend-types.h"
%#include "xdr/Tokend-ledger-entries-account.h"
%#include "xdr/Tokend-ledger-entries-signer.h"
%#include "xdr/Tokend-ledger-entries-fee.h"
%#include "xdr/Tokend-ledger-entries-balance.h"
%#include "xdr/Tokend-ledger-entries-asset.h"
%#include "xdr/Tokend-ledger-entries-asset-pair.h"
%#include "xdr/Tokend-ledger-entries-reference.h"
%#include "xdr/Tokend-ledger-entries-statistics.h"
%#include "xdr/Tokend-ledger-entries-offer.h"
%#include "xdr/Tokend-ledger-entries-account-limits.h"
%#include "xdr/Tokend-ledger-entries-reviewable-request.h"
%#include "xdr/Tokend-ledger-entries-external-system-id.h"
%#include "xdr/Tokend-ledger-entries-sale.h"
%#include "xdr/Tokend-ledger-entries-key-value.h"
%#include "xdr/Tokend-ledger-entries-account-KYC.h"
%#include "xdr/Tokend-ledger-entries-external-system-id-pool-entry.h"
%#include "xdr/Tokend-ledger-entries-statistics-v2.h"
%#include "xdr/Tokend-ledger-entries-pending-statistics.h"
%#include "xdr/Tokend-ledger-entries-contract.h"
%#include "xdr/Tokend-ledger-entries-atomic-swap-bid.h"
%#include "xdr/Tokend-ledger-entries-account-role.h"
%#include "xdr/Tokend-ledger-entries-account-rule.h"
%#include "xdr/Tokend-ledger-entries-signer-role.h"
%#include "xdr/Tokend-ledger-entries-signer-rule.h"
%#include "xdr/Tokend-ledger-entries-license.h"
%#include "xdr/Tokend-ledger-entries-stamp.h"
%#include "xdr/Tokend-ledger-entries-poll.h"
%#include "xdr/Tokend-ledger-entries-vote.h"
%#include "xdr/Tokend-ledger-entries-account-specific-rule.h"

namespace stellar
{

// the 'Thresholds' type is packed uint8_t values
// defined by these indexes
enum ThresholdIndexes
{
    MASTER_WEIGHT = 0,
    LOW = 1,
    MED = 2,
    HIGH = 3
};


struct LedgerEntry
{
    uint32 lastModifiedLedgerSeq; // ledger the LedgerEntry was last changed

    union switch (LedgerEntryType type)
    {
    case ACCOUNT:
        AccountEntry account;
    case SIGNER:
        SignerEntry signer;
    case FEE:
        FeeEntry feeState;
    case BALANCE:
        BalanceEntry balance;
    case ASSET:
        AssetEntry asset;
    case REFERENCE_ENTRY:
        ReferenceEntry reference;
    case STATISTICS:
        StatisticsEntry stats;
    case ACCOUNT_LIMITS:
        AccountLimitsEntry accountLimits;
	case ASSET_PAIR: 
		AssetPairEntry assetPair;
	case OFFER_ENTRY:
		OfferEntry offer;
	case REVIEWABLE_REQUEST:
		ReviewableRequestEntry reviewableRequest;
	case EXTERNAL_SYSTEM_ACCOUNT_ID:
		ExternalSystemAccountID externalSystemAccountID;
	case SALE:
		SaleEntry sale;
	case KEY_VALUE:
	    KeyValueEntry keyValue;
	case ACCOUNT_KYC:
        AccountKYCEntry accountKYC;
    case EXTERNAL_SYSTEM_ACCOUNT_ID_POOL_ENTRY:
        ExternalSystemAccountIDPoolEntry externalSystemAccountIDPoolEntry;
    case LIMITS_V2:
        LimitsV2Entry limitsV2;
    case STATISTICS_V2:
        StatisticsV2Entry statisticsV2;
    case PENDING_STATISTICS:
        PendingStatisticsEntry pendingStatistics;
    case CONTRACT:
        ContractEntry contract;
    case ATOMIC_SWAP_BID:
        AtomicSwapBidEntry atomicSwapBid;
    case ACCOUNT_ROLE:
        AccountRoleEntry accountRole;
    case ACCOUNT_RULE:
        AccountRuleEntry accountRule;
    case SIGNER_RULE:
        SignerRuleEntry signerRule;
    case SIGNER_ROLE:
        SignerRoleEntry signerRole;
    case LICENSE:
        LicenseEntry license;
    case STAMP:
        StampEntry stamp;
    case POLL:
        PollEntry poll;
    case VOTE:
        VoteEntry vote;
    case ACCOUNT_SPECIFIC_RULE:
        AccountSpecificRuleEntry accountSpecificRule;
    }
    data;

    // reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

// list of all envelope types used in the application
// those are prefixes used when building signatures for
// the respective envelopes
enum EnvelopeType
{
    SCP = 1,
    TX = 2,
    AUTH = 3
};
}
