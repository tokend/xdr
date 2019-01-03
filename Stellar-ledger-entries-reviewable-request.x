// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-reviewable-request-asset.h"
%#include "xdr/Stellar-reviewable-request-issuance.h"
%#include "xdr/Stellar-reviewable-request-withdrawal.h"
%#include "xdr/Stellar-reviewable-request-sale.h"
%#include "xdr/Stellar-reviewable-request-update-KYC.h"
%#include "xdr/Stellar-reviewable-request-limits-update.h"
%#include "xdr/Stellar-reviewable-request-AML-alert.h"
%#include "xdr/Stellar-reviewable-request-update-sale-details.h"
%#include "xdr/Stellar-reviewable-request-invoice.h"
%#include "xdr/Stellar-reviewable-request-contract.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap.h"
%#include "xdr/Stellar-reviewable-request-atomic-swap-bid.h"

namespace stellar
{

enum ReviewableRequestType
{
    ASSET_CREATE = 0,
	ASSET_UPDATE = 1,
	PRE_ISSUANCE_CREATE = 2,
	ISSUANCE_CREATE = 3,
	WITHDRAW = 4,
	SALE = 5,
	LIMITS_UPDATE = 6,
    AML_ALERT = 7,
	UPDATE_KYC = 8,
	UPDATE_SALE_DETAILS = 9,
	NONE = 10, // use this request type in ReviewRequestOp extended result if additional info is not required
	INVOICE = 11,
	CONTRACT = 12,
	CREATE_ATOMIC_SWAP_BID = 16,
	ATOMIC_SWAP = 17
};

struct TasksExt {
    // Tasks are represented by a bitmask
    uint32 allTasks;
    uint32 pendingTasks;

    // External details vector consists of comments written by request reviewers
    longstring externalDetails<>;

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

// ReviewableRequest - request reviewable by admin
struct ReviewableRequestEntry {
	uint64 requestID;
	Hash hash; // hash of the request body
	AccountID requestor;
	longstring rejectReason;
	AccountID reviewer;
	string64* reference; // reference for request which will act as an unique key for the request (will reject request with the same reference from same requestor)
	int64 createdAt; // when request was created

	union switch (ReviewableRequestType type) {
		case ASSET_CREATE:
			AssetCreationRequest assetCreationRequest;
		case ASSET_UPDATE:
			AssetUpdateRequest assetUpdateRequest;
		case PRE_ISSUANCE_CREATE:
			PreIssuanceRequest preIssuanceRequest;
		case ISSUANCE_CREATE:
			IssuanceRequest issuanceRequest;
		case WITHDRAW:
			WithdrawalRequest withdrawalRequest;
		case SALE:
			SaleCreationRequest saleCreationRequest;
        case LIMITS_UPDATE:
            LimitsUpdateRequest limitsUpdateRequest;
        case AML_ALERT:
            AMLAlertRequest amlAlertRequest;
        case UPDATE_KYC:
            UpdateKYCRequest updateKYCRequest;
        case UPDATE_SALE_DETAILS:
            UpdateSaleDetailsRequest updateSaleDetailsRequest;
        case INVOICE:
            InvoiceRequest invoiceRequest;
        case CONTRACT:
            ContractRequest contractRequest;
        case CREATE_ATOMIC_SWAP_BID:
            ASwapBidCreationRequest aSwapBidCreationRequest;
        case ATOMIC_SWAP:
            ASwapRequest aSwapRequest;
	} body;

	TasksExt tasks;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
	}
    ext;
};

}