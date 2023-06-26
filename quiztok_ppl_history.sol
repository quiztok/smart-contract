pragma solidity ^0.5.1;



library SafeMath {
 
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }
 
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }
 
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }
 
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}




contract Context {
    constructor () internal { }
    // solhint-disable-previous-line no-empty-blocks

    function _msgSender() internal view returns (address payable) {
        return msg.sender;
    }

    function _msgData() internal view returns (bytes memory) {
        this; 
        return msg.data;
    }
}

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor () internal {
        _owner = _msgSender();
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(isOwner(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Returns true if the caller is the current owner.
     */
    function isOwner() public view returns (bool) {
        return _msgSender() == _owner;
    }


}


contract QuiztokAd is Ownable{

    struct adInfo{
        string clientWallet; // 광고주 주소 
        string adType; // 광고 유형
        string campaignName; // 캠페인 이름
        string adGroupName; // 광고 그룹 이름
        string keywordTarget; // 타겟 키워드
        string exceptKeyword; //타겟 제외 키워드
        string paymentType; // 광고 유형
    }


    struct campaignImpressions { // 노출수
        string quizId;
        string landingPage;
    }

    struct campaignNumberOfClicks { // 클릭수
        string quizId;
        string landingPage;
    }

    struct campaignConversions { // 전환수
        string quizId;
        string landingPage;
    }



    struct adTxInfo{
        uint id;
    }



    

     mapping(uint256 => adInfo) adInfos;
     mapping (string => adInfo[]) private adInfoData; 


    mapping(uint256 => campaignImpressions) campaignImpressionsInfo;
    mapping (uint256 => campaignImpressions[]) private campaignImpressionsData; 


    mapping (uint256 => campaignNumberOfClicks) campaignNumberOfClicksInfo;
    mapping (uint256 => campaignNumberOfClicks[]) private campaignNumberOfClicksData; 

    mapping (uint256 => campaignConversions) campaignConversionsInfo;
    mapping (uint256 => campaignConversions[]) private campaignConversionsData; 



    function setCampaignConversions( uint256 _adInfoId, uint256 _num, string memory _quizId, string memory _landingPage ) public onlyOwner {  // 광고 전환 수 히스토리 저장
        campaignConversions storage newCampaignConversions = campaignConversionsInfo[_num];

        newCampaignConversions.quizId =  _quizId;
        newCampaignConversions.landingPage = _landingPage;

        campaignConversionsData[_adInfoId].push(newCampaignConversions);

    }

    function getCampaignConversions(uint256  _adInfoId, uint256 _num) public view returns(string memory, string memory){ // 광고 전환 수 히스토리 보기
        campaignConversions storage r = campaignConversionsData[_adInfoId][_num-1];
        return (r.quizId, r.landingPage); 
    }

    function getCampaignConversionsCount(uint256 _adInfoId)  public view returns(uint256){
        return campaignConversionsData[_adInfoId].length;
    }
    

   function setCampaignNumberOfClicks( uint256 _adInfoId, uint256 _num, string memory _quizId, string memory _landingPage ) public onlyOwner { // 광고 클릭 수 히스토리 저장
        campaignNumberOfClicks storage newCampaignNumberOfClicks = campaignNumberOfClicksInfo[_num];

        newCampaignNumberOfClicks.quizId = _quizId;
        newCampaignNumberOfClicks.landingPage = _landingPage;

        campaignNumberOfClicksData[_adInfoId].push(newCampaignNumberOfClicks);
    }


    function getCampaignNumberOfClicks(uint256  _adInfoId, uint256 _num) public view returns(string memory, string memory){ // 광고 클릭 수 히스토리 보기
        campaignNumberOfClicks storage r  = campaignNumberOfClicksData[_adInfoId][_num-1];
        return (r.quizId, r.landingPage); 
    }

    function getCampaignNumberOfClicksCount(uint256 _adInfoId)  public view returns(uint256){
        return campaignNumberOfClicksData[_adInfoId].length;
    }


    function setCampaignImpressions( uint256 _adInfoId, uint256 _num, string memory _quizId, string memory _landingPage ) public onlyOwner { // 광고 노출 히스토리 저장
    
        campaignImpressions storage newCampaignImpressions = campaignImpressionsInfo[_num];
        
        newCampaignImpressions.quizId = _quizId;
        newCampaignImpressions.landingPage = _landingPage;
        
        campaignImpressionsData[_adInfoId].push(newCampaignImpressions);
    }

 
    function getCampaignImpressions(uint256  _adInfoId, uint256 _num) public view returns(string memory, string memory){ // 광고 노출 히스토리 보기
        campaignImpressions storage r = campaignImpressionsData[_adInfoId][_num-1];
        return (r.quizId, r.landingPage); 
    }

    function getCampaignImpressionsCount(uint256 _adInfoId)  public view returns(uint256){
        return campaignImpressionsData[_adInfoId].length;
    }


    function getAdEfficiency(uint256  _adInfoId)  public view returns(uint256 , uint256 , uint256 ) {
        return (getCampaignImpressionsCount(_adInfoId) , getCampaignNumberOfClicksCount(_adInfoId), getCampaignConversionsCount(_adInfoId));
    }


    function getAdTotalCount(string memory _clientWallet) public view returns(uint256){
     if(adInfoData[_clientWallet].length <=0){
            return 0;
        }else{
            return adInfoData[_clientWallet].length;
        }
    }


    function registerAdInfo( uint256 _id, string memory _clientWallet,  string memory _adType , string memory _campaignName, string memory _adGroupName , 
                             string memory _keywordTarget, string memory _exceptKeyword, string memory _paymentType   ) public onlyOwner {
                                   
        uint id = _id;
        adInfo storage newAdInfo = adInfos[id];
        newAdInfo.clientWallet = _clientWallet;
        newAdInfo.adType = _adType;
        newAdInfo.campaignName = _campaignName;
        newAdInfo.adGroupName = _adGroupName;
        newAdInfo.keywordTarget = _keywordTarget;
        newAdInfo.exceptKeyword = _exceptKeyword;
        newAdInfo.paymentType = _paymentType;
        
        adInfoData[_clientWallet].push(newAdInfo);
    }

    function getAdInfo(string memory _clientWallet, uint256 id ) public view returns(string memory, string memory,string memory ,string memory ,string memory ,string memory ,string memory){
        adInfo storage r = adInfoData[_clientWallet][id-1];
        return(r.clientWallet,r.adType,r.campaignName,r.adGroupName , r.keywordTarget, r.exceptKeyword, r.paymentType);
    }


}