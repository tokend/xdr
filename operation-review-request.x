

%#include "xdr/ledger-entries.h"
%#include "xdr/operation-payment.h"
%#include "xdr/operation-manage-offer.h"
%#include "xdr/operation-create-redemption-request.h"
%#include "xdr/operation-create-close-deferred-payment-request.h"

namespace stellar
{
//: Actions that can be performed on request that is being reviewed
enum ReviewRequestOpAction {
    //: Approve request
    APPROVE = 1,
    //: Reject request
    REJECT = 2,
    //: Permanently reject request
    PERMANENT_REJECT = 3
};

/* ReviewRequestOp

        Approves or rejects reviewable request

        Threshold: high

        Result: ReviewRequestResult
*/
//: Review details of a Limits Update request
struct LimitsUpdateDetails {
    //: Limits entry containing new limits to set
    LimitsV2Entry newLimitsV2;

    //:reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Review details of a Withdraw Request
struct WithdrawalDetails {
    //: External details updated on a Withdraw review
    string externalDetails<>;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Details of AML Alert
struct AMLAlertDetails {
    //: Comment on reason of AML Alert
    string comment<>;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

struct ContractDetails {
    longstring details;

    // Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
            void;
    }
    ext;
};

//: Details of a payment reviewable request
struct BillPayDetails {
    //: Details of payment
    PaymentOp paymentDetails;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Details of a request review
struct ReviewDetails {
    //: Tasks to add to pending
    uint32 tasksToAdd;
    //: Tasks to remove from pending
    uint32 tasksToRemove;
    //: Details of the current review
    string externalDetails<>;
    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Extended result of the review request operation containing details specific to a Create Sale Request
struct SaleExtended {
    //: ID of the newly created sale as a result of Create Sale Request successful review
    uint64 saleID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Extended result of the review request operation containing details specific to a Create Atomic Swap Bid Request
struct AtomicSwapAskExtended
{
    //: ID of the newly created ask as a result of Create Atomic Swap Ask Request successful review
    uint64 askID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Extended result of the review request operation containing details specific to a `CREATE_POLL` request
struct CreatePollExtended
{
    //: ID of the newly created poll
    uint64 pollID;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Extended result of a review request operation containing details specific to a Create Atomic Swap Request
struct AtomicSwapBidExtended
{
    //: ID of a ask to apply atomic swap to
    uint64 askID;
    //: AccountID of a ask owner
    AccountID askOwnerID;
    //: Account id of an bid owner
    AccountID bidOwnerID;
    //: Base asset for the atomic swap
    AssetCode baseAsset;
    //: Quote asset for the atomic swap
    AssetCode quoteAsset;
    //: Amount in base asset to exchange
    uint64 baseAmount;
    //: Amount in quote asset to exchange
    uint64 quoteAmount;
    //: Price of base asset in terms of quote
    uint64 price;
    //: Balance in base asset of a ask owner
    BalanceID askOwnerBaseBalanceID;
    //: Balance in base asset of an bid owner
    BalanceID bidOwnerBaseBalanceID;
    //: Amount which was unlocked on bid owner base balance after bid removing
    uint64 unlockedAmount;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
            void;
    }
    ext;
};


struct CreateDeferredPaymentResult
{
    uint64 deferredPaymentID;
    AccountID destination;
    AccountID source;

    EmptyExt ext;
};


struct DataCreationExtended {
    //: Owner of the created data entry
    AccountID owner;
    //: ID of the created data entry
    uint64 id;
    //: Security type of the created data entry
    uint64 type;
};


//: Extended result of a Review Request operation containing details specific to certain request types
struct ExtendedResult {
    //: Indicates whether or not the request that is being reviewed was applied
    bool fulfilled;
    //: typeExt is used to pass ReviewableRequestType along with details specific to a request type
    union switch(ReviewableRequestType requestType) {
    case CREATE_SALE:
        SaleExtended saleExtended;
    case NONE:
        void;
    case CREATE_ATOMIC_SWAP_BID:
        AtomicSwapBidExtended atomicSwapBidExtended;
    case CREATE_ATOMIC_SWAP_ASK:
        AtomicSwapAskExtended atomicSwapAskExtended;
    case CREATE_POLL:
        CreatePollExtended createPoll;
    case MANAGE_OFFER:
        ManageOfferResult manageOfferResult;
    case CREATE_PAYMENT:
        PaymentResult paymentResult;
    case PERFORM_REDEMPTION:
        CreateRedemptionRequestResult createRedemptionResult;
    case DATA_CREATION:
        DataCreationExtended dataCreationExtended;
    case CREATE_DEFERRED_PAYMENT:
        CreateDeferredPaymentResult createDeferredPaymentResult;
    case CLOSE_DEFERRED_PAYMENT:
         CloseDeferredPaymentResult closeDeferredPaymentResult;

    } typeExt;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: Review Request operation
struct ReviewRequestOp
{
    //: ID of a request that is being reviewed
    uint64 requestID;
    //: Hash of a request that is being reviewed
    Hash requestHash;
    //: requestDetails is used to pass request type along with details specific to it.
    union switch(ReviewableRequestType requestType) {
    case CREATE_WITHDRAW:
        WithdrawalDetails withdrawal;
    case UPDATE_LIMITS:
        LimitsUpdateDetails limitsUpdate;
    case CREATE_AML_ALERT:
        AMLAlertDetails amlAlertDetails;
    case CREATE_INVOICE:
        BillPayDetails billPay;
    case MANAGE_CONTRACT:
        ContractDetails contract;
    default:
        void;
    } requestDetails;
    //: Review action defines an action performed on the pending ReviewableRequest
    ReviewRequestOpAction action;
    //: Contains reject reason
    longstring reason;
    //: Details of the ReviewRequest operation
    ReviewDetails reviewDetails;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

/******* ReviewRequest Result ********/
//: Result code of the ReviewRequest operation
enum ReviewRequestResultCode
{
    //: Codes considered as "success" for an operation
    //: Operation is applied successfully
    SUCCESS = 0,

    //: Codes considered as "failure" for an operation
    //: Reject reason must be empty on approve and not empty on reject/permanent
    INVALID_REASON = -1,
    //: Unknown action to perform on ReviewableRequest
    INVALID_ACTION = -2,
    //: Actual hash of the request and provided hash are mismatched
    HASH_MISMATCHED = -3,
    //: ReviewableRequest is not found
    NOT_FOUND = -4,
    //: Actual type of a reviewable request and provided type are mismatched
    TYPE_MISMATCHED = -5,
    //: Reject is not allowed. Only permanent reject should be used
    REJECT_NOT_ALLOWED = -6,
    //: External details must be a valid JSON
    INVALID_EXTERNAL_DETAILS = -7,
    //: Source of ReviewableRequest is blocked
    REQUESTOR_IS_BLOCKED = -8,
    //: Permanent reject is not allowed. Only reject should be used
    PERMANENT_REJECT_NOT_ALLOWED = -9,
    //: Trying to remove tasks which are not set
    REMOVING_NOT_SET_TASKS = -100,// cannot remove tasks which are not set

    //: Asset requests
    //: Trying to create an asset that already exists
    ASSET_ALREADY_EXISTS = -200,
    //: Trying to update an asset that does not exist
    ASSET_DOES_NOT_EXISTS = -210,

    //: Issuance requests
    //: After the issuance request application, issued amount will exceed max issuance amount
    MAX_ISSUANCE_AMOUNT_EXCEEDED = -400,
    //: Trying to issue more than it is available for issuance
    INSUFFICIENT_AVAILABLE_FOR_ISSUANCE_AMOUNT = -410,
    //: Funding account will exceed UINT64_MAX
    FULL_LINE = -420,
    //: It is not allowed to set system tasks
    SYSTEM_TASKS_NOT_ALLOWED = -430,
    //: Incorrect amount precision
    INCORRECT_PRECISION = -440,

    //: Sale creation requests
    //: Trying to create a sale for a base asset that does not exist
    BASE_ASSET_DOES_NOT_EXISTS = -500,
    //: Trying to create a sale with hard cap that will exceed max issuance amount
    HARD_CAP_WILL_EXCEED_MAX_ISSUANCE = -510,
    //: Trying to create a sale with preissued amount that is less than the hard cap
    INSUFFICIENT_PREISSUED_FOR_HARD_CAP = -520,
    //: Trying to create a sale for a base asset that cannot be found
    BASE_ASSET_NOT_FOUND = -530,
    //: There is no asset pair between default quote asset and quote asset
    ASSET_PAIR_NOT_FOUND = -540,
    //: Trying to create a sale with one of the quote assets that doesn't exist
    QUOTE_ASSET_NOT_FOUND = -550,

    //: Change role
    //: Trying to remove zero tasks
    NON_ZERO_TASKS_TO_REMOVE_NOT_ALLOWED = -600,
    //: There is no account role with provided id
    ACCOUNT_ROLE_TO_SET_DOES_NOT_EXIST = -610,


    //: Update sale details
    //: Trying to update details of a non-existing sale
    SALE_NOT_FOUND = -700,

    //: Deprecated: Invoice requests
    AMOUNT_MISMATCHED = -1010, // amount does not match
    DESTINATION_BALANCE_MISMATCHED = -1020, // invoice balance and payment balance do not match
    NOT_ALLOWED_ACCOUNT_DESTINATION = -1030,
    REQUIRED_SOURCE_PAY_FOR_DESTINATION = -1040, // not allowed shift fee responsibility to destination
    SOURCE_BALANCE_MISMATCHED = -1050, // source balance must match invoice sender account
    CONTRACT_NOT_FOUND = -1060,
    INVOICE_RECEIVER_BALANCE_LOCK_AMOUNT_OVERFLOW = -1070,
    INVOICE_ALREADY_APPROVED = -1080,

    // codes considered as "failure" for the payment operation
    //: Deprecated: Invoice requests
    PAYMENT_V2_MALFORMED = -1100,
    UNDERFUNDED = -1110,
    LINE_FULL = -1120,
    DESTINATION_BALANCE_NOT_FOUND = -1130,
    BALANCE_ASSETS_MISMATCHED = -1140,
    SRC_BALANCE_NOT_FOUND = -1150,
    REFERENCE_DUPLICATION = -1160,
    STATS_OVERFLOW = -1170,
    LIMITS_EXCEEDED = -1180,
    NOT_ALLOWED_BY_ASSET_POLICY = -1190,
    INVALID_DESTINATION_FEE = -1200,
    INVALID_DESTINATION_FEE_ASSET = -1210, // destination fee asset must be the same as source balance asset
    FEE_ASSET_MISMATCHED = -1220,
    INSUFFICIENT_FEE_AMOUNT = -1230,
    BALANCE_TO_CHARGE_FEE_FROM_NOT_FOUND = -1240,
    PAYMENT_AMOUNT_IS_LESS_THAN_DEST_FEE = -1250,
    DESTINATION_ACCOUNT_NOT_FOUND = -1260,

    //: Limits update requests
    //: Trying to create a limits update request for both account and account type at the same time
    CANNOT_CREATE_FOR_ACC_ID_AND_ACC_TYPE = 1300,
    //: Trying to set invalid limits, i.e. with dayly limit greater than weekly limit
    INVALID_LIMITS = 1310,
    //: There is no account with passed ID for limits update request
    ACCOUNT_NOT_FOUND = -1311,
    //: There is no role with passed ID for limits update request
    ROLE_NOT_FOUND = -1312,

    //: Deprecated: Contract requests
    CONTRACT_DETAILS_TOO_LONG = -1400, // customer details reached length limit

    // Atomic swap
    BASE_ASSET_CANNOT_BE_SWAPPED = -1500,
    QUOTE_ASSET_CANNOT_BE_SWAPPED = -1501,
    ATOMIC_SWAP_BID_OWNER_FULL_LINE = -1504,

    //KYC
    //:Signer data is invalid - either weight is wrong or details are invalid
    INVALID_SIGNER_DATA = -1600,

    // offer
    MANAGE_OFFER_FAILED = -1700,

    // payment
    PAYMENT_FAILED = -1800,

    // Update Data
    DATA_NOT_FOUND = -1900
};
//: Result of applying the review request with result code
union ReviewRequestResult switch (ReviewRequestResultCode code)
{
case SUCCESS:
    ExtendedResult success;
case MANAGE_OFFER_FAILED:
    ManageOfferResultCode manageOfferCode;
case PAYMENT_FAILED:
    PaymentResultCode paymentCode;
default:
    void;
};

}
