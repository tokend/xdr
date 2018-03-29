// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-ledger-entries-account.h"
%#include "xdr/Stellar-ledger-entries-fee.h"
%#include "xdr/Stellar-ledger-entries-balance.h"
%#include "xdr/Stellar-ledger-entries-payment-request.h"
%#include "xdr/Stellar-ledger-entries-asset.h"
%#include "xdr/Stellar-ledger-entries-asset-pair.h"
%#include "xdr/Stellar-ledger-entries-reference.h"
%#include "xdr/Stellar-ledger-entries-account-type-limits.h"
%#include "xdr/Stellar-ledger-entries-statistics.h"
%#include "xdr/Stellar-ledger-entries-offer.h"
%#include "xdr/Stellar-ledger-entries-account-limits.h"
%#include "xdr/Stellar-ledger-entries-invoice.h"
%#include "xdr/Stellar-ledger-entries-reviewable-request.h"
%#include "xdr/Stellar-ledger-entries-external-system-id.h"
%#include "xdr/Stellar-ledger-entries-sale.h"
%#include "xdr/Stellar-ledger-entries-account-KYC.h"

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

enum LedgerEntryType
{
    ACCOUNT = 0,
    FEE = 2,
    BALANCE = 4,
    PAYMENT_REQUEST = 5,
    ASSET = 6,
    REFERENCE_ENTRY = 7,
    ACCOUNT_TYPE_LIMITS = 8,
    STATISTICS = 9,
    TRUST = 10,
    ACCOUNT_LIMITS = 11,
	ASSET_PAIR = 12,
	OFFER_ENTRY = 13,
    INVOICE = 14,
	REVIEWABLE_REQUEST = 15,
	EXTERNAL_SYSTEM_ACCOUNT_ID = 16,
	SALE = 17,
	ACCOUNT_KYC = 18
};


struct LedgerEntry
{
    uint32 lastModifiedLedgerSeq; // ledger the LedgerEntry was last changed

    union switch (LedgerEntryType type)
    {
    case ACCOUNT:
        AccountEntry account;
    case FEE:
        FeeEntry feeState;
    case BALANCE:
        BalanceEntry balance;
    case PAYMENT_REQUEST:
        PaymentRequestEntry paymentRequest;
    case ASSET:
        AssetEntry asset;
    case REFERENCE_ENTRY:
        ReferenceEntry reference;
    case ACCOUNT_TYPE_LIMITS:
        AccountTypeLimitsEntry accountTypeLimits;
    case STATISTICS:
        StatisticsEntry stats;
    case TRUST:
        TrustEntry trust;
    case ACCOUNT_LIMITS:
        AccountLimitsEntry accountLimits;
	case ASSET_PAIR: 
		AssetPairEntry assetPair;
	case OFFER_ENTRY:
		OfferEntry offer;
    case INVOICE:
        InvoiceEntry invoice;
	case REVIEWABLE_REQUEST:
		ReviewableRequestEntry reviewableRequest;
	case EXTERNAL_SYSTEM_ACCOUNT_ID:
		ExternalSystemAccountID externalSystemAccountID;
	case SALE:
		SaleEntry sale;
	case ACCOUNT_KYC:
        AccountKYCEntry accountKYC;
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
