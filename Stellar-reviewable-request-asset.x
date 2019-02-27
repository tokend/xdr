%#include "xdr/Stellar-types.h"

namespace stellar
{

//: AssetCreationRequest is used to create asset with provided parameters
struct AssetCreationRequest {
    //: Code of the asset to create
    AssetCode code;
    //: Public key of the signer that will perform pre issuance
    AccountID preissuedAssetSigner;
    //: Maximal amount to be issued
    uint64 maxIssuanceAmount;
    //: Amount to pre issue on asset creation
    uint64 initialPreissuedAmount;
    //: Bit mask of policies to create asset with
    uint32 policies;
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by the admin
    longstring creatorDetails; // details set by requester
     //: Type of asset, selected arbitrarily. Can be used to restrict usage of asset
    uint64 type;
    //: Used to keep track of rejected requests update. On each rejected AssetCreationRequest update, sequenceNumber increases
    uint32 sequenceNumber;
    //: Number of significant decimal places
    uint32 trailingDigitsCount;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: AssetUpdateRequest is used to update asset with provided parameters
struct AssetUpdateRequest {
    //: Code of asset to update
    AssetCode code;
    //: Arbitrary stringified JSON object that can be used to attach data to be reviewed by the admin
    longstring creatorDetails; // details set by requester
    //: New policies to set, will override existing ones
    uint32 policies;
    //: Used to keep track of rejected requests update. On each rejected AssetUpdateRequest update, sequenceNumber increases
    uint32 sequenceNumber;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

//: AssetChangePreissuedSigner is used to update pre issued asset signer
struct AssetChangePreissuedSigner
{
    //: code of the asset to update
    AssetCode code;
    //: Public key of signer which will be new pre issuer
    AccountID accountID;
    //: Content signature of pre issuer signer
    //: Content equals hash of `<code>:<accountID>`
    DecoratedSignature signature;

    //: Reserved for future use
    union switch (LedgerVersion v)
    {
    case EMPTY_VERSION:
        void;
    }
    ext;
};

}
