//
//  TermAndConditionVC.swift
//  PaynetOne
//
//  Created by Icloud Vinatti on 30/08/2022.
//

import UIKit

class TermAndConditionVC: BaseUI {
    private var textView  : UITextView!
    private let htmlText = """
        <b>I. CHÍNH SÁCH HỦY GIAO DỊCH</b><br/>
                <i>1. Điều kiện hủy giao dịch:</i><br/>
        Khách hàng có thể hủy giao dịch kể từ lúc bấm nút "Xác nhận" đến trước thời điểm thanh toán thành công.<br/>
                <i>2. Phương thức hủy giao dịch:</i><br/>
        Sau khi tạo mã QR để thanh toán thành công, khi muốn huỷ giao dịch, quý khách hàng vui lòng tạo đơn hàng khác.<br/>
        <b>II. CHÍNH SÁCH HOÀN TIỀN</b><br/>
                <i>1. Lệ phí hoàn trả:</i> phí hoàn trả sẽ hoàn toàn do Paynet Việt Nam chi trả hoàn toàn nếu lỗi đó thuộc về công ty.<br/>
                <i>2. Hình thức hoàn trả:</i> Công ty cam kết hoàn trả 100% phí mà khách hàng đã thanh toán cho chúng tôi thông qua các hình thức như: tài khoản Paynet One hoặc chuyển khoản cho khách hàng. Thời gian hoàn lại trong vòng 10 ngày làm việc.<br/>
                <i>3. Điều kiện áp dụng:</i><br/>
        Theo các điều khoản và điều kiện được quy định trong Chính sách Hoàn tiền này và tạo thành một phần của Điều khoản dịch vụ, Paynet Việt Nam đảm bảo quyền lợi của Người mua bằng cách cho phép gửi yêu cầu hoàn trả tiền trước khi hết hạn.
        Paynet One Đảm bảo là một dịch vụ được cung cấp bởi Paynet Việt Nam, theo yêu cầu của Người dùng, để hỗ trợ Người dùng trong việc giải quyết các xung đột có thể phát sinh trong quá trình giao dịch. Người dùng có thể liên hệ với nhau để thỏa thuận về việc giải quyết tranh chấp của họ hoặc báo cáo lên chính quyền địa phương có liên quan nhờ hỗ trợ họ trong việc giải quyết bất kỳ tranh chấp xảy ra trước, trong hoặc sau khi sử dụng Paynet One đảm bảo.<br/>
                <b>III. CHÍNH SÁCH BẢO MẬT THÔNG TIN</b><br/>
                <i>1. Đối tượng và phạm vi áp dụng</i><br/>
                <b>Đối tượng áp dụng:</b><br/>
        - Người sử dụng là cá nhân, tổ chức, doanh nghiệp.<br/>
                <b>Phạm vi áp dụng:</b><br/>
        - Việc thu thập, xử lý, sử dụng, lưu trữ, và bảo vệ Thông tin cá nhân của Bạn khi sử dụng sản phẩm, dịch vụ do Paynet Việt Nam cung ứng.<br/>
        - Các dịch vụ trực tuyến, phương tiện, công cụ, ứng dụng, dịch vụ liên quan đến việc cung ứng sản phẩm, dịch vụ của Paynet Việt Nam, bất kể Bạn sử dụng phương thức nào để truy cập hoặc sử dụng.<br/>
                <i>2. Các thông tin Paynet Việt Nam thu thập</i><br/>
        Nhằm bảo vệ quyền lợi của Bạn tại Paynet Việt Nam, thực hiện các quy định pháp luật khi cung ứng dịch vụ Trung gian thanh toán, thương mại điện tử. Paynet Việt Nam tiến hành các hoạt động thu thập thông tin về Bạn gồm các loại thông tin sau đây:<br/>
                <b>Thông tin mà Bạn cung cấp:</b><br/>
        - Thông tin Bạn cung cấp khi thiết lập quan hệ sử dụng dịch vụ, hoặc hợp tác, hoặc thông qua việc tạo tài khoản dịch vụ trên website, ứng dụng của Paynet Việt Nam, hoặc khi sử dụng một tính năng, sản phẩm mới của Paynet Việt Nam.<br/>
        - Các thông tin cập nhật, sửa đổi, bổ sung, thay thế;<br/>
        - Thông tin về các giao dịch và hoạt động của Bạn;<br/>
        - Thông tin, dữ liệu về việc sử dụng tính năng dịch vụ của Bạn (nếu có);<br/>
        - Các thông tin mà Bạn cung cấp khi phát sinh yêu cầu từ Paynet Việt Nam, hoặc từ Bạn.<br/>
                <b>Thông tin được thu thập tự động:</b><br/>
        - Thông tin được gửi đến Paynet Việt Nam từ máy tính, điện thoại, hoặc các thiết bị khác mà Bạn sử dụng để tải, truy cập như: Dữ liệu các website, ứng dụng Bạn Truy cập, địa chỉ IP, ID nhận dạng thiết bị, loại thiết bị, thông tin máy tính, thiết bị di động, thiết bị mạng, số liệu thống kê hiển thị của website, ứng dụng truy cập và các dữ liệu cơ bản khác;<br/>
        - Khi Bạn truy cập sản phẩm, dịch vụ của Paynet Việt Nam, hoặc truy cập website, ứng dụng của bên thứ ba có hợp tác dịch vụ trực tuyến mà Paynet Việt Nam cung cấp, Paynet Việt Nam và các đối tác kinh doanh và nhà cung cấp của Paynet Việt Nam có thể sử dụng cookie và các công cụ kiểm tra (gọi chung là Cookies) để nhận diện Khách hàng là một Người sử dụng và để tùy chỉnh trải nghiệm trực tuyến của Bạn, Dịch vụ Khách hàng sử dụng cũng như nội dung và quảng cáo trực tuyến khác; đo lường hiệu quả của các chương trình khuyến mãi và thực hiện phân tích; và để giảm thiểu rủi ro, ngăn chặn gian lận tiềm ẩn và thúc đẩy niềm tin và sự an toàn đối với các dịch vụ của Paynet Việt Nam.<br/>
        - Một số khía cạnh và tính năng của Dịch vụ, sản phẩm của Paynet Việt Nam chỉ khả dụng khi sử dụng Cookies, vì vậy nếu Bạn chọn tắt hoặc từ chối Cookies, việc sử dụng Dịch vụ của bạn có thể bị hạn chế hoặc không thể thực hiện.<br/>
        - Khi bạn sử dụng thiết bị để truy cập, sử dụng dịch vụ, tùy theo cấu trúc, tính năng, thiết kế từng loại thiết bị, nhà cung cấp, cho phép Bạn thiết lập, cấu hình, lựa chọn chức năng cho phép Dịch vụ, sản phẩm của Paynet Việt Nam được truy cập, sử dụng một, một số, hoặc toàn bộ thông tin nhất định theo tùy chọn của bạn.<br/>
        Thông tin được tạo ra bởi hệ thống của Paynet Việt Nam, hoặc các kênh hỗ trợ của Paynet Việt Nam như:<br/>
        - Thông tin ghi nhận Bạn trên hệ thống như Mã định danh, AppID, và bất kỳ thông tin nào khác mà hệ thống của Paynet Việt Nam tạo ra để để nhận diện bạn khi truy cập, sử dụng sản phẩm, dịch vụ của Paynet Việt Nam.<br/>
        Thông tin Bạn cung cấp tại các phương tiện thông tin công khai như Fanpage của Paynet Việt Nam trên Facebook, Zalo, website, ứng dụng của Paynet Việt Nam<br/>
        Thông tin khác mà Paynet Việt Nam cần nhằm thực hiện nghĩa vụ pháp lý theo quy định pháp luật, thông lệ quốc tế về cung cấp dịch vụ thanh toán, dịch vụ ngân hàng và các dịch vụ liên quan.<br/>
                <i>3. Mục đích thu thập thông tin</i><br/>
        Paynet Việt Nam thu thập thông tin để sử dụng cho các mục đích dưới đây:<br/>
        Để vận hành và cung cấp dịch vụ của Paynet Việt Nam bao gồm:<br/>
        - Cung cấp các dịch vụ và tính năng cho Bạn;<br/>
        - Cung cấp, duy trì và cải thiện các sản phẩm và dịch vụ của Paynet Việt Nam.<br/>
        - Kiểm tra, xác minh tính chính xác, trung thực, đầy đủ các thông tin cung cấp; đánh giá, phân loại mức độ rủi ro theo quy định pháp luật Việt Nam;<br/>
        - Bảo vệ quyền lợi của Bạn đối với các hoạt động sử dụng dịch vụ, tính năng do Paynet Việt Nam cung ứng trong đó có các thông tin tài chính.<br/>
        - Xác thực thông tin, quyền truy cập của Bạn trong suốt quá trình tạo lập, sử dụng dịch vụ, hợp tác giữa Paynet Việt Nam và Bạn.<br/>
        - Ghi nhớ thông tin để Bạn không phải nhập lại trong quá trình truy cập hoặc lần tiếp theo khi Bạn truy cập vào dịch vụ.<br/>
        - Liên lạc với Khách hàng và đối tác về tài khoản, dịch vụ, nội dung hợp tác thông qua các cuộc gọi thoại, tin nhắn SMS, ZaloOA, ZMS hoặc email hay có thể là bằng văn bản hoặc các hình thức khác;<br/>
        - Tạo kết nối dịch vụ giữa Tài khoản của Bạn và tài khoản hoặc nền tảng của Bên thứ ba (như các tổ chức tín dụng, tổ chức cung ứng dịch vụ chuyển mạch tài chính và bù trừ điện tử, Bên cung cấp hàng hóa, dịch vụ, bên thứ ba khác theo sự đồng ý của Bạn trong từng trường hợp);<br/>
        - Kiểm tra khả năng tín nhiệm và khả năng thanh toán hoặc đánh giá, phát hiện và/hoặc khắc phục gian lận, giả mạo hoặc các hành vi có thể bị cấm hoặc vi phạm pháp luật.<br/>
        - Để bảo vệ bạn khỏi những hành vi gian lận sử dụng sai mục đích các thông tin của Bạn, Paynet Việt Nam có thể thu thập thông tin về bạn và các tương tác của Bạn, đánh giá máy tính, điện thoại và các thiết bị khác mà Bạn dùng để truy cập vào dịch vụ của Paynet Việt Nam để nhận dạng bất kỳ phần mềm, hay hoạt động xâm phạm nào.<br/>
        Các thông tin khác để đánh giá việc đã tuân thủ, đang tuân thủ và có thể tiếp tục tuân thủ tất cả các nghĩa vụ của Bạn theo các Thỏa thuận sử dụng dịch vụ Trung gian thanh toán, Điều Khoản Chung, Hợp Đồng Điện Tử, các quy định, cảnh báo, thông báo được Paynet Việt Nam đăng tải công khai trên http://paynetvn.com hoặc thông tin đến từng Khách hàng qua tin nhắn (SMS), Notify, ZaloOA, điện thoại, hay công cụ khác.<br/>
        Để thực hiện các hoạt động tuân thủ quy định pháp luật, yêu cầu của cơ quan quản lý đối với hoạt động kinh doanh của Paynet Việt Nam.<br/>
        Thực hiện cam kết của Paynet Việt Nam với các nhà cung cấp hàng hóa dịch vụ mà Bạn mua bán hàng hóa, dịch vụ (không bao gồm các thông tin cá nhân theo quy định pháp luật dùng để định danh Bạn);<br/>
        Quản lý truy cập, và thực hiện các biện pháp an toàn, an ninh và tính toàn vẹn cho các dịch vụ mà Paynet Việt Nam cung cấp cho Bạn.<br/>
        Hỗ trợ Bạn: Thông qua các thông tin thu thập được, Paynet Việt Nam tiến hành các hoạt động hỗ trợ một cách tốt nhất các vấn đề phát sinh đối với Bạn trong quá trình sử dụng như giải quyết thắc mắc, hỗ trợ tra soát, khiếu nại, theo dõi, cải thiện dịch vụ hỗ trợ khách hàng,…<br/>
        Nghiên cứu và phát triển: Paynet Việt Nam có thể sử dụng thông tin thu thập được để phục vụ công tác nghiên cứu, phát triển nhằm nâng cao chất lượng dịch vụ, quản lý và bảo vệ các thông tin, hệ thống kỹ thuật dịch vụ, đo lường hiệu suất dịch vụ và cải thiện sản phẩm, dịch vụ do Paynet Việt Nam cung ứng.<br/>
        Quảng bá về các sản phẩm, dịch vụ, chương trình khuyến mại, nghiên cứu, khảo sát, tin tức, thông tin cập nhật, các sự kiện, các quảng cáo và nội dung có liên quan về các dịch vụ của Paynet Việt Nam và các dịch vụ của các đối tác có hợp tác với Paynet Việt Nam.<br/>
        Các thủ tục và yêu cầu pháp lý Paynet Việt Nam có thể sử dụng thông tin thu thập được để điều tra hoặc giải quyết các khiếu nại hoặc tranh chấp liên quan đến việc sử dụng dịch vụ của Bạn, hoặc các hoạt động khác được pháp luật hiện hành cho phép.<br/>
                <i>4. Cung cấp thông tin</i><br/>
        - Paynet Việt Nam cam kết bảo mật thông tin của Bạn theo đúng quy định pháp luật về bảo vệ quyền riêng tư. Paynet Việt Nam không cung cấp, chia sẻ, phát tán thông tin cá nhân của Bạn mà Paynet Việt Nam đã thu thập cho bên thứ ba trừ trường hợp được Bạn yêu cầu, đồng ý hoặc theo các quy định pháp luật hiện hành.<br/>
        - Trong trường hợp cung cấp thông tin theo yêu cầu của Bạn, yêu cầu đó có thể Có thể bằng văn bản, hoặc thông qua tính năng dịch vụ do Paynet Việt Nam cung ứng, email, điện thoại hoặc bất kỳ hình thức nào khác có ghi nhận nội dung yêu cầu hoặc đồng ý của bạn.<br/>
                <i>5. Thời hạn lưu trữ thông tin thu thập</i><br/>
        - Paynet Việt Nam lưu trữ thông tin để thực hiện các nghĩa vụ pháp lý theo quy định pháp luật Việt Nam và thông lệ quốc tế lĩnh vực tài chính, và/hoặc các mục đích kinh doanh hợp pháp của Paynet Việt Nam theo quy định pháp luật và quy định của Ngân hàng Nhà nước.<br/>
        - Việc lưu trữ được thực hiện trên nguyên tắc đảm bảo tuân thủ các quy định pháp luật hiện hành, và tiêu chuẩn, thông lệ quốc tế về lưu trữ, xử lý thông tin trong lĩnh vực tài chính, tiền tệ mà Paynet Việt Nam có tham gia.<br/>
        - Thời gian lưu trữ có thể được Paynet Việt Nam thực hiện tối thiểu theo quy định pháp luật với từng loại thông tin thu thập.<br/>
                <i>6. Sửa đổi, bổ sung, thay đổi chính sách quyền riêng tư</i><br/>
        - Bất kỳ sửa đổi, bổ sung, thay thế nào đối với Chính sách Quyền riêng tư này sẽ được thông báo bởi Paynet Việt Nam trên website chính thức https://paynetvn.com/ hoặc ứng dụng cung ứng dịch vụ Paynet Việt Nam.<br/>
        - Trừ trường hợp nội dung thông báo sửa đổi, bổ sung thay thế có quy định khác về thời gian hiệu lực, các sửa đổi, bổ sung thay thế sẽ được áp dụng ngay tại thời điểm công khai.<br/>
        - Trong phạm vi được pháp luật cho phép, việc Bạn tiếp tục sử dụng các dịch vụ do Paynet Việt Nam cung ứng, đồng nghĩa với việc Bạn đồng ý với các nội dung cập nhật tại Chính sách này.<br/>
                <i>7. Luật điều chỉnh</i><br/>
        Chính sách quyền riêng tư này được giải thích và thi hành theo Pháp luật Việt Nam.
    <style>body { font-family: 'helveticaneue'; font-size: 14px; text-align: justify; }</style>
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ĐIỀU KHOẢN VÀ CHÍNH SÁCH"
        initUI()
        configUI()
        configBackgorundColor()
        
    }
    
    private func initUI(){
        textView  = UITextView()
    }
    private func configUI(){
        view.addSubview(textView)
        textView.safeTop(toView: view, space: 8)
        textView.bottom(toView: view, space: 10)
        textView.horizontal(toView: view, space: 14)
        textView.contentInsetAdjustmentBehavior = .never
        textView.isEditable = false
        textView.attributedText = htmlText.htmlToAttributedString
    }
    
    override func configBackgorundColor() {
        if isDarkMode{
            view.applyViewDarkMode()
            textView.textColor = .white
        }else{
            view.backgroundColor = .white
        }
    }
}
