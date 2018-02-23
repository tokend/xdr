// Copyright 2015 Stellar Development Foundation and contributors. Licensed
// under the Apache License, Version 2.0. See the COPYING file at the root
// of this distribution or at http://www.apache.org/licenses/LICENSE-2.0

%#include "xdr/Stellar-types.h"
%#include "xdr/Stellar-reviewable-request-asset.h"
%#include "xdr/Stellar-reviewable-request-issuance.h"
%#include "xdr/Stellar-reviewable-request-withdrawal.h"
%#include "xdr/Stellar-reviewable-request-sale.h"
%#include "xdr/Stellar-reviewable-request-change-KYC.h"
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
	CHANGE_KYC = 6 
};

// ReviewableRequest - request reviewable by admin
struct ReviewableRequestEntry {
	uint64 requestID;
	Hash hash; // hash of the request body
	AccountID requestor;
	string256 rejectReason;
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
		case CHANGE_KYC:
		    ChangeKYCRequest changeKYCRequest;
	} body;

	// reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
