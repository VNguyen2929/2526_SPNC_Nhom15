const API_BASE_URL = 'http://localhost:3000/api';
let currentSelectedLessonId = null;
let questionIndex = 0;
let questionIndexStart = 0;
let interval;
let timeLimit;
let quiz = [];
let backupQuestion = null;
let timeLeft = 60;
let timerId;
let startTime;

let MainThemePlay = new Audio("audio/nhacnen.mp3");
let StartPlay = new Audio("audio/lets play.mp3");
let wrongPlay = new Audio("audio/wrong.mp3");
let correctPlay = new Audio("audio/correct.mp3");
let callPlay = new Audio("audio/correct.mp3");
let callPlay1 = new Audio("audio/correct.mp3");
let fifty50Play = new Audio("audio/correct.mp3");
let fifty50Play1 = new Audio("audio/correct.mp3");
let audiencePlay = new Audio("audio/correct.mp3");
let audiencePlay1 = new Audio("audio/correct.mp3");
let inGamePlay = new Audio("audio/lets play.mp3");
let OutTime = new Audio("audio/Het_thoi_luong.mp3");
let Win = new Audio("audio/Het_thoi_luong.mp3");

let authContainer = document.querySelector(".auth-container");
let modeStudentBtn = document.getElementById("mode-student-btn");
let modeTeacherBtn = document.getElementById("mode-teacher-btn");
let teacherLoginForm = document.getElementById("teacher-login-form");
let studentStartGameForm = document.getElementById("student-start-game");
let loginTeacherBtn = document.getElementById("login-teacher-btn");
let startAsStudentBtn = document.getElementById("start-as-student-btn");
let teacherUsernameInput = document.getElementById("teacher-username");
let teacherPasswordInput = document.getElementById("teacher-password");
let backToAuthBtn = document.getElementById("back-to-auth-btn");

let adminDashboard = document.getElementById("admin-dashboard");
let logoutBtn = document.getElementById("logout-btn");
let topicUl = document.getElementById("topic-ul");
let currentTopicDisplay = document.getElementById("current-topic-display");
let questionManagementArea = document.getElementById('question-management-area');
let currentLessonDisplay = document.getElementById('current-lesson-display');

let startBox = document.querySelector(".start-box");
let startBtn = document.querySelector(".start-game-btn");
let userInput = document.querySelector(".username");

let gameBox = document.querySelector(".game-box");
let timer = document.querySelector(".timer");
let currQuestionAmount = document.querySelector(".current-question-amount");
let lifelineBox = document.querySelector(".life-line-display-box");
let callView = document.querySelector(".call");
let callAnswer = document.querySelector(".call-answer");
let auCover = document.querySelector(".au-cover");
let auBox = document.querySelectorAll(".au-box");
let bx = document.querySelector(".bx");
let questionBox = document.querySelector(".question");
let questionText = document.querySelector(".question-text");
let questionNumber = document.querySelector(".question-number");
let option = document.querySelectorAll(".option");
let optionText = document.querySelectorAll(".opt");
let nextQuestionBtn = document.querySelector(".next-question-btn");
let playAgainBtn = document.querySelector(".playAgain-btn");
let fify50Btn = document.querySelector(".fify50");
let addCancel = document.querySelectorAll(".cancel");
let CallBtn = document.querySelector(".callAFriend");
let askBtn = document.querySelector(".askTheAudience");
let swapBtn = document.querySelector(".swapQuestion");
let prices = document.querySelector(".prices");
let amountWon = document.querySelector(".amount-won");

const addModal = document.getElementById('add-question-modal');
const addBtn = document.getElementById('add-question-btn');
const closeBtn = document.getElementById('close-add-q-modal');
const form = document.getElementById('add-question-form');

window.addEventListener("load", () => {
    MainThemePlay.play();
    loadTopicsForStudent();
});

function loadTopicsForStudent() {
    const topicSelect = document.getElementById('student-topic-select');
    if (!topicSelect) return;

    fetch(`${API_BASE_URL}/topics`)
        .then(res => res.json())
        .then(topics => {
            topicSelect.innerHTML = '<option value="">-- Chọn Chủ đề --</option>';
            topics.forEach(t => {
                let opt = document.createElement('option');
                opt.value = t.id;
                opt.textContent = t.name;
                topicSelect.appendChild(opt);
            });
        })
        .catch(err => console.error("Lỗi:", err));
}

document.addEventListener('change', function (e) {
    if (e.target && e.target.id === 'student-topic-select') {
        const topicId = e.target.value;
        const lessonSelect = document.getElementById('student-lesson-select');

        if (!topicId) {
            lessonSelect.innerHTML = '<option value="">-- Vui lòng chọn chủ đề trước --</option>';
            return;
        }

        lessonSelect.innerHTML = '<option value="">-- Đang tải bài học... --</option>';

        fetch(`${API_BASE_URL}/lessons/${topicId}`)
            .then(res => res.json())
            .then(lessons => {
                lessonSelect.innerHTML = '<option value="">-- Chọn bài học --</option>';
                lessons.forEach(l => {
                    let opt = document.createElement('option');
                    opt.value = l.id;
                    opt.textContent = l.name;
                    lessonSelect.appendChild(opt);
                });
            })
            .catch(err => {
                console.error("Lỗi:", err);
                lessonSelect.innerHTML = '<option value="">Lỗi tải dữ liệu</option>';
            });
    }
});

function getQuestions(data) {
    let rand;
    let count = 0;
    let countMed = 0;
    let countHard = 0;
    while (count < 4) {
        rand = Math.floor(Math.random() * data.easy.length);
        if (!quiz.includes(data.easy[rand])) {
            quiz.push(data.easy[rand]);
            count++;
        }
    }
    while (countMed < 3) {
        rand = Math.floor(Math.random() * data.medium.length);
        if (!quiz.includes(data.medium[rand])) {
            quiz.push(data.medium[rand]);
            countMed++;
        }
    }
    while (countHard < 3) {
        rand = Math.floor(Math.random() * data.hard.length);
        if (!quiz.includes(data.hard[rand])) {
            quiz.push(data.hard[rand]);
            countHard++;
        }
    }
    generateQuestion();
}

function generateQuestion() {
    if (!quiz || quiz.length === 0 || questionIndex >= quiz.length) {
        console.error("Lỗi:", quiz);
        return;
    }

    const currentQuiz = quiz[questionIndex];
    questionText.textContent = currentQuiz.question_text;

    if (currentQuiz.options && currentQuiz.options.length >= 4) {
        optionText[0].textContent = currentQuiz.options[0];
        optionText[1].textContent = currentQuiz.options[1];
        optionText[2].textContent = currentQuiz.options[2];
        optionText[3].textContent = currentQuiz.options[3];
    }

    questionBox.classList.add("show");
    option.forEach((ele, index) => {
        ele.style.visibility = "visible";
        ele.classList.add(index < 2 ? "show-1" : "show-2");
    });

    questionNumber.textContent = `Câu số: ${questionIndex + 1} / ${quiz.length}`;
}

function check(ele) {
    let id = parseInt(ele.id);
    let correctAnswerId = parseInt(quiz[questionIndex].correct_answer);

    if (id == correctAnswerId) {
        ele.classList.add("correct");
        correctPlay.play();
        clearInterval(timerId);

        if (questionIndex === (quiz.length - 1)) {
            questionIndex++;
            setTimeout(() => {
                Win.play();
                result();
            }, 2000);
        } else {
            setTimeout(() => {
                nextQuestion();
            }, 2000);
        }
    } else {
        ele.classList.add("wrong");
        wrongPlay.play();
        clearInterval(timerId);

        option.forEach(op => {
            if (parseInt(op.id) === correctAnswerId) {
                op.classList.add("show-correct");
            }
        });

        setTimeout(() => {
            result();
        }, 2000);
    }
    disableOptions();
}

function result() {
    clearInterval(timerId);
    if (inGamePlay) {
        inGamePlay.pause();
        inGamePlay.currentTime = 0;
    }

    const endTime = new Date();
    const durationInSeconds = startTime ? Math.floor((endTime - startTime) / 1000) : 0;
    const displayMinutes = Math.floor(durationInSeconds / 60);
    const displaySeconds = durationInSeconds % 60;
    const playTimeStr = new Date().toLocaleString('vi-VN');

    const totalQuestions = quiz.length || 10;
    const score = (questionIndex / totalQuestions) * 10;

    let prize = "0 VND";
    if (questionIndex >= 10) prize = "250.000.000 VND";
    else if (questionIndex >= 7) prize = "22.000.000 VND";
    else if (questionIndex >= 3) prize = "2.000.000 VND";
    else prize = "0 VND";

    const selectedLessonId = document.getElementById('student-lesson-select').value;

    const resultData = {
        student_id: (isHomeMode && currentHomeStudent) ? currentHomeStudent.id : null,
        lesson_id: parseInt(selectedLessonId),
        play_mode: isHomeMode ? 'Ở Nhà' : 'Trên Lớp',
        correct_answers: questionIndex,
        score: score
    };

    fetch(`${API_BASE_URL}/results`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(resultData)
    })
        .then(res => res.json())
        .then(data => console.log(data.message))
        .catch(err => console.error("Lỗi:", err));

    const overlay = document.getElementById('final-result-overlay');
    const content = document.getElementById('final-card-content');

    if (overlay && content) {
        overlay.style.display = 'flex';

        content.innerHTML = `
            <div class="final-result-card" style="text-align: center; padding: 20px; color: white;">
                <h2 style="color: gold; margin-bottom: 10px;">KẾT THÚC LƯỢT CHƠI</h2>
                <p style="color: #aaa; font-size: 0.9rem;">${isHomeMode ? 'CHẾ ĐỘ: LUYỆN TẬP TẠI NHÀ' : 'CHẾ ĐỘ: THI ĐẤU TRÊN LỚP'}</p>
                <hr style="border: 1px solid #3689e7; margin: 15px 0;">
                
                <p style="margin: 15px 0;">Số câu trả lời đúng: <br> 
                    <span style="font-size: 2.5rem; color: gold; font-weight: bold;">${questionIndex} / ${totalQuestions}</span>
                </p>

                ${isHomeMode ? `
                    <p style="margin: 15px 0;">Điểm số đạt được: <br> 
                        <span style="font-size: 3.5rem;  font-weight: bold;">${score.toFixed(1)}</span>
                    </p>
                ` : `
                    <p style="margin: 15px 0;">Tiền thưởng: <br> 
                        <span style="font-size: 2.2rem;  font-weight: bold;">${prize}</span>
                    </p>
                `}
                
                <div style="background: rgba(255,255,255,0.1); padding: 10px; border-radius: 10px; margin-top: 15px; font-size: 0.9rem; color: #ddd;">
                    <p>Thời gian chơi: ${playTimeStr}</p>
                    <p>Thời gian làm bài: ${displayMinutes} phút ${displaySeconds} giây</p>
                </div>
                
              <div style="background: rgba(255,255,255,0.1); padding: 12px; border-radius: 10px; margin-top: 15px; font-size: 1.1rem; color: #ddd;">
                    <p>⏱️ Thời gian hoàn thành: <b style="color: gold;">${displayMinutes} phút ${displaySeconds} giây</b></p>
                </div>
                <button onclick="gracefulRestart()" class="btn-restart" 
                    style="background: gold; color: black; padding: 12px 35px; border-radius: 25px; font-weight: bold; border: none; cursor: pointer; margin-top: 25px; font-size: 1.1rem; box-shadow: 0 4px 15px rgba(255,215,0,0.3);">
                    ⟲ CHƠI LẠI / CHỌN BÀI KHÁC
                </button>
            </div>
        `;
    }
}

function StartTimer() {
    timeLeft = 60;
    timer.innerHTML = timeLeft;
    timer.classList.remove("less-time");

    clearInterval(timerId);
    timerId = setInterval(countdownLogic, 1000);
}

function stopTimer() {
    clearInterval(timerId);
}

function resumeTimer() {
    clearInterval(timerId);
    timerId = setInterval(countdownLogic, 1000);
}

function countdownLogic() {
    timeLeft--;
    timer.innerHTML = timeLeft < 10 ? "0" + timeLeft : timeLeft;

    if (timeLeft <= 10) {
        timer.classList.add("less-time");
    }

    if (timeLeft <= 0) {
        clearInterval(timerId);
        timeIsUp();
    }
}

function timeIsUp() {
    option.forEach(ele => {
        if (parseInt(ele.id) === parseInt(quiz[questionIndex].correct_answer)) {
            ele.classList.add("show-correct");
        }
    });

    disableOptions();
    disableAllLifeLines();

    inGamePlay.pause();
    OutTime.play();

    setTimeout(() => {
        result();
    }, 2000);
}

function updatePriceUI() {
    const allLis = document.querySelectorAll('.prices li');
    allLis.forEach(li => {
        li.style.background = "transparent";
        li.style.color = li.classList.contains('milestone') ? "#fff" : "gold";
    });

    let currentPos = 9 - questionIndex;
    if (currentPos >= 0 && currentPos <= 9) {
        allLis[currentPos].style.background = "gold";
        allLis[currentPos].style.color = "black";
    }
}

function disableAllLifeLines() {
    askBtn.style.pointerEvents = "none";
    CallBtn.style.pointerEvents = "none";
    fify50Btn.style.pointerEvents = "none";
    if (swapBtn) swapBtn.style.pointerEvents = "none";
}
function disableFifty50() {
    addCancel[0].classList.add("show");
    fify50Btn.style.pointerEvents = "none";
}

function disableCall() {
    addCancel[1].classList.add("show");
    CallBtn.style.pointerEvents = "none";
}

function disableAudience() {
    addCancel[2].classList.add("show");
    askBtn.style.pointerEvents = "none";
}

function showConfirmLifeline(message, onConfirm) {
    const modal = document.getElementById('confirm-lifeline-modal');
    const text = document.getElementById('confirm-lifeline-text');
    const btnYes = document.getElementById('btn-confirm-yes');
    const btnNo = document.getElementById('btn-confirm-no');

    text.innerHTML = message;
    modal.style.display = 'flex';

    stopTimer();
    inGamePlay.pause();

    btnYes.onclick = () => {
        modal.style.display = 'none';
        onConfirm();
    };

    btnNo.onclick = () => {
        modal.style.display = 'none';
        inGamePlay.play();
        resumeTimer();
    };
}

fify50Btn.addEventListener("click", function () {
    showConfirmLifeline("💡 Bạn có chắc chắn muốn sử dụng quyền trợ giúp <b>50/50</b> để loại bỏ 2 phương án sai không?", () => {
        fifty50Play1.currentTime = 0;
        fifty50Play1.play();
        disableFifty50();

        setTimeout(() => {
            fifty50Play1.addEventListener('ended', () => {
                fifty50Play.play();
                let correctId = parseInt(quiz[questionIndex].correct_answer);
                let wrongIds = [0, 1, 2, 3].filter(id => id !== correctId);
                wrongIds.sort(() => Math.random() - 0.5);
                let idsToHide = [wrongIds[0], wrongIds[1]];

                option.forEach(ele => {
                    if (idsToHide.includes(parseInt(ele.id))) {
                        ele.style.visibility = "hidden";
                    }
                });
                inGamePlay.play();
                enableOptions();
                resumeTimer();
            }, { once: true });
        }, 2000);
    });
});

let continueGameBtn = document.getElementById("continue-game-btn");
if (!continueGameBtn) {
    continueGameBtn = document.createElement("button");
    continueGameBtn.id = "continue-game-btn";
    continueGameBtn.innerHTML = "▶ TIẾP TỤC CHƠI";

    continueGameBtn.style.cssText = "display: none; position: fixed; bottom: 8%; left: 50%; transform: translateX(-50%); background: linear-gradient(180deg, #11c466, #0a8242); color: white; border: 3px solid white; padding: 12px 35px; border-radius: 40px; font-weight: bold; font-size: 1.2rem; cursor: pointer; z-index: 99999; box-shadow: 0 10px 20px rgba(0,0,0,0.5), 0 0 15px #11c466; text-transform: uppercase; transition: all 0.2s ease;";

    continueGameBtn.onmouseover = () => {
        continueGameBtn.style.transform = "translateX(-50%) scale(1.05)";
        continueGameBtn.style.boxShadow = "0 10px 25px rgba(0,0,0,0.7), 0 0 25px #11c466";
    };
    continueGameBtn.onmouseout = () => {
        continueGameBtn.style.transform = "translateX(-50%) scale(1)";
        continueGameBtn.style.boxShadow = "0 10px 20px rgba(0,0,0,0.5), 0 0 15px #11c466";
    };

    document.body.appendChild(continueGameBtn);
}

askBtn.addEventListener("click", () => {
    showConfirmLifeline("💡 Bạn có chắc chắn muốn hỏi <b>ý kiến khán giả</b> trong trường quay không?", () => {
        disableAudience();
        disableOptions();

        try { audiencePlay1.currentTime = 0; audiencePlay1.play(); } catch (e) { }

        setTimeout(() => {
            lifelineBox.classList.add("show");
            auCover.classList.add("show");
            try { audiencePlay.play(); } catch (e) { }

            try {
                let correctId = parseInt(quiz[questionIndex].correct_answer);
                let correctPercent = questionIndex < 5 ? Math.floor(Math.random() * 21) + 70 : Math.floor(Math.random() * 21) + 40;
                let remaining = 100 - correctPercent;
                let wrongPercents = [];
                for (let i = 0; i < 2; i++) {
                    let p = Math.floor(Math.random() * remaining);
                    wrongPercents.push(p);
                    remaining -= p;
                }
                wrongPercents.push(remaining);
                wrongPercents.sort(() => Math.random() - 0.5);

                let wrongIndex = 0;
                auBox.forEach(ele => {
                    let id = parseInt(ele.id);
                    let percent = (id === correctId) ? correctPercent : wrongPercents[wrongIndex++];

                    if (ele.children && ele.children.length >= 2) {
                        ele.children[0].textContent = percent + "%";
                        ele.children[1].style.height = percent + "%";
                    }
                });
            } catch (err) { console.error("Lỗi:", err); }

            setTimeout(() => {
                continueGameBtn.style.display = "block";

                continueGameBtn.onclick = () => {
                    continueGameBtn.style.display = "none";
                    lifelineBox.classList.remove("show");
                    auCover.classList.remove("show");

                    try { inGamePlay.play(); } catch (e) { }
                    enableOptions();
                    resumeTimer();
                };
            }, 2000);

        }, 2500);
    });
});

CallBtn.addEventListener("click", () => {
    showConfirmLifeline("💡 Bạn có chắc chắn muốn <b>Trợ lý ảo</b> để hỗ trợ trả lời câu hỏi không?", () => {
        disableCall();
        disableOptions();

        try { callPlay1.currentTime = 0; callPlay1.play(); } catch (e) { }

        setTimeout(() => {
            lifelineBox.classList.add("show");
            callView.classList.add("show");
            try { callPlay.play(); } catch (e) { }

            try {
                let correctId = parseInt(quiz[questionIndex].correct_answer);
                let correctText = "đáp án đó";
                if (!isNaN(correctId) && optionText[correctId]) {
                    correctText = optionText[correctId].textContent;
                }

                let ansCall = [
                    `[Trợ lý Ảo]: Đang phân tích dữ liệu... Đã quét xong hàng triệu tài liệu. Xác suất 99.9% đáp án đúng là: ${correctText}.`,
                    `[Trợ lý Ảo]: Xin chào! Thuật toán của tôi vừa tính toán xong. Phương án tối ưu và chính xác nhất để khóa lại là: ${correctText}.`,
                    `[Trợ lý Ảo]: Bíp bíp... Không phát hiện lỗi logic nào trong phương án này. Hãy tin vào dữ liệu của tôi và chọn: ${correctText}.`,
                    `[Trợ lý Ảo]: Dựa trên cơ sở tri thức hiện tại của toàn cầu, tôi đề xuất bạn nên chọn: ${correctText}. Chúc human (con người) may mắn!`
                ];
                let rand = Math.floor(Math.random() * ansCall.length);

                setTimeout(function () {
                    if (callAnswer) {
                        callAnswer.textContent = ansCall[rand];
                        callAnswer.classList.add("show");
                    }

                    continueGameBtn.style.display = "block";

                    continueGameBtn.onclick = () => {
                        continueGameBtn.style.display = "none";
                        lifelineBox.classList.remove("show");
                        callView.classList.remove("show");
                        callAnswer.classList.remove("show");

                        try { inGamePlay.play(); } catch (e) { }
                        enableOptions();
                        resumeTimer();
                    };

                }, 2000);

            } catch (err) {
                console.error("Lỗi:", err);
                enableOptions();
                resumeTimer();
            }
        }, 2500);
    });
});

if (swapBtn) {
    swapBtn.addEventListener("click", () => {
        if (!backupQuestion) return;
        showConfirmLifeline("💡 Bạn có chắc chắn muốn sử dụng quyền <b>Đổi câu hỏi</b> khác không?", () => {
            StartPlay.play();
            quiz[questionIndex] = backupQuestion;
            removeStyles();
            generateQuestion();
            addCancel[3].classList.add("show");
            swapBtn.style.pointerEvents = "none";
            swapBtn.style.opacity = "0.5";
            backupQuestion = null;

            setTimeout(() => {
                inGamePlay.play();
                resumeTimer();
            }, 2000);
        });
    });
}

function disableOptions() {
    option.forEach(ele => {
        ele.classList.add("already-answered");
    });
}

function enableOptions() {
    option.forEach(ele => {
        ele.classList.remove("already-answered");
    });
}

function showNextBtn() {
    nextQuestionBtn.classList.add("show");
}

function playAgain() {
    playAgainBtn.classList.add("show");
}

function hideNextBtn() {
    nextQuestionBtn.classList.remove("show");
}

function removeStyles() {
    option.forEach(ele => {
        ele.classList.remove("correct");
        ele.classList.remove("wrong");
        ele.classList.remove("show-correct");
        ele.classList.remove("already-answered");
        ele.style.visibility = "visible";
    });
    if (lifelineBox) lifelineBox.classList.remove("show");
    if (auCover) auCover.classList.remove("show");
    if (callView) callView.classList.remove("show");
    if (callAnswer) callAnswer.classList.remove("show");
}

function removeOption() {
    option.forEach(ele => {
        ele.classList.remove("correct");
        ele.classList.remove("wrong");
        ele.classList.remove("show-correct");
        ele.classList.remove("already-answered");
        ele.style.visibility = "hidden";
    })
}

function currentAmount() {
    const allPrices = prices.querySelectorAll('li');
    allPrices.forEach(li => li.style.cssText = "background: transparent; color: gold;");

    let displayIndex = 14 - questionIndex;
    if (displayIndex >= 0) {
        allPrices[displayIndex].style.backgroundColor = "gold";
        allPrices[displayIndex].style.color = "black";
        allPrices[displayIndex].style.fontWeight = "bold";
    }
}

function removePrevious() {
    let countPrev = 14 - questionIndex + 1;
    let child = prices.children[countPrev];
    if (countPrev === 0 || countPrev === 5 || countPrev === 10) {
        child.style.backgroundColor = "#000";
        child.style.color = "#fff";
    }
    else {
        child.style.backgroundColor = "#000";
        child.style.color = "gold";
    }
}

function reset() {
    if (questionIndexStart > 0) {
        questionIndex++;
    }
    if (questionIndex > 0) {
        removePrevious();
    }
    removeStyles();
    MainThemePlay.play();
    lifelineBox.classList.remove("show");
    auCover.classList.remove("show");
    callView.classList.remove("show");

    addCancel[0].classList.remove("show");
    addCancel[1].classList.remove("show");
    addCancel[2].classList.remove("show");
    if (addCancel[3]) addCancel[3].classList.remove("show");

    fify50Btn.style.pointerEvents = "auto";
    CallBtn.style.pointerEvents = "auto";
    askBtn.style.pointerEvents = "auto";

    if (swapBtn) {
        swapBtn.style.pointerEvents = "auto";
        swapBtn.style.opacity = "1";
    }

    amountWon.classList.remove("show");
}
nextQuestionBtn.addEventListener("click", nextQuestion);

function nextQuestion() {
    if (questionIndexStart > 0) {
        questionIndex++;
    }
    questionIndexStart++;

    if (questionIndex >= quiz.length) {
        result();
        return;
    }

    removeStyles();
    enableOptions();

    generateQuestion();

    updatePriceUI();
    StartTimer();

    questionNumber.textContent = `Câu số: ${questionIndex + 1} / ${quiz.length}`;
}

function switchMode(isTeacher) {
    if (isTeacher) {
        modeTeacherBtn.classList.add("active-mode");
        modeStudentBtn.classList.remove("active-mode");
        teacherLoginForm.classList.remove("hidden");
        studentStartGameForm.classList.add("hidden");
    } else {
        modeStudentBtn.classList.add("active-mode");
        modeTeacherBtn.classList.remove("active-mode");
        teacherLoginForm.classList.add("hidden");
        studentStartGameForm.classList.remove("hidden");
    }
}

modeStudentBtn.addEventListener('click', () => switchMode(false));
modeTeacherBtn.addEventListener('click', () => switchMode(true));
let currentTeacher = null;

loginTeacherBtn.addEventListener('click', (e) => {
    e.preventDefault();

    const username = teacherUsernameInput.value.trim();
    const password = teacherPasswordInput.value.trim();

    if (!username || !password) {
        return alert("⚠️ Vui lòng nhập Tên đăng nhập và Mật khẩu!");
    }

    fetch(`${API_BASE_URL}/teachers/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username: username, password: password })
    })
        .then(res => res.json())
        .then(data => {
            if (data.teacher) {
                currentTeacher = data.teacher;
                authContainer.classList.add("hidden");
                adminDashboard.classList.remove("hidden");

                const tabTeachersBtn = document.getElementById('tab-teachers-btn');
                if (currentTeacher.username === 'admin') {
                    if (tabTeachersBtn) tabTeachersBtn.style.display = 'block';
                } else {
                    if (tabTeachersBtn) tabTeachersBtn.style.display = 'none';
                }

                alert(`Đăng nhập thành công! Xin chào ${currentTeacher.full_name}`);
                initAdminDashboard();
            }
            else {
                alert(" " + data.message);
                teacherPasswordInput.value = "";
            }
        })
        .catch(err => {
            alert("Máy chủ chưa phản hồi. Vui lòng kiểm tra lại Server!");
            console.error("Lỗi:", err);
        });
});

logoutBtn.addEventListener('click', () => {
    adminDashboard.classList.add("hidden");
    authContainer.classList.remove("hidden");
    teacherUsernameInput.value = "";
    teacherPasswordInput.value = "";
    currentTeacher = null;

    document.getElementById('admin-topic-content').classList.remove('hidden');
    document.getElementById('admin-student-content').classList.add('hidden');
});


startAsStudentBtn.addEventListener('click', () => {
    const selectedLessonId = document.getElementById('student-lesson-select').value;
    if (!selectedLessonId) {
        alert("⚠️ Vui lòng chọn Chủ đề và Bài học trước khi vào phòng chờ!");
        return;
    }

    authContainer.classList.add("hidden");

    startBox.classList.remove("hidden");
    startBox.classList.remove("show");

    gameBox.classList.remove("show");
    gameBox.classList.add("hidden");
    adminDashboard.classList.add("hidden");
    MainThemePlay.play();
});

startBtn.addEventListener("click", () => {
    const selectedLessonId = document.getElementById('student-lesson-select').value;
    if (!selectedLessonId) return alert("Vui lòng chọn bài học!");

    fetch(`${API_BASE_URL}/questions/quiz/${selectedLessonId}`)
        .then(res => res.json())
        .then(data => {
            if (data.message && data.message.includes("Không đủ")) return alert(data.message);

            quiz = data.quiz;
            backupQuestion = data.backup;
            questionIndex = 0;
            questionIndexStart = 0;
            startTime = new Date();

            let allCancels = document.querySelectorAll(".cancel");
            allCancels.forEach(cancel => cancel.classList.remove("show"));

            fify50Btn.style.pointerEvents = "";
            CallBtn.style.pointerEvents = "";
            askBtn.style.pointerEvents = "";
            if (swapBtn) {
                swapBtn.style.pointerEvents = "";
                swapBtn.style.opacity = "1";
            }

            lifelineBox.classList.remove("show");
            auCover.classList.remove("show");
            callView.classList.remove("show");
            amountWon.classList.remove("show");

            startBox.classList.add("hidden");
            startBox.classList.add("show");
            gameBox.classList.remove("hidden");
            gameBox.classList.add("show");

            nextQuestion();
            StartTimer();
            updatePriceUI();

            MainThemePlay.pause();
            StartPlay.play();
        })
        .catch(err => {
            console.error("Lỗi:", err);
            alert("Lỗi tải dữ liệu. Vui lòng kiểm tra Server!");
        });
});
playAgainBtn.addEventListener("click", () => {
    startBox.classList.remove("show");
    gameBox.classList.remove("show");
    reset();
});

backToAuthBtn.addEventListener('click', () => {
    startBox.classList.add("hidden");
    startBox.classList.add("show");

    authContainer.classList.remove("hidden");
    MainThemePlay.pause();
    MainThemePlay.currentTime = 0;
});

function initAdminDashboard() {
    fetchTopics();
}

function fetchTopics() {
    fetch(`${API_BASE_URL}/topics`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(topics => {
            renderTopics(topics);
        })
        .catch(error => {
            console.error('Lỗi:', error);
            topicUl.innerHTML = '<li style="color: var(--wrong-color);">Không thể tải Chủ đề. Vui lòng kiểm tra Server API.</li>';
        });
}

function renderTopics(topics) {
    topicUl.innerHTML = '';
    if (topics.length === 0) {
        topicUl.innerHTML = '<li style="color: white; list-style: none;">Chưa có Chủ đề nào.</li>';
        return;
    }
    topics.forEach(topic => {
        const li = document.createElement('li');
        li.classList.add('topic-item');
        li.dataset.topicId = topic.id;

        const nameSpan = document.createElement('span');
        nameSpan.classList.add('topic-name');
        nameSpan.textContent = `📂 ${topic.name}`;

        const actionDiv = document.createElement('div');
        actionDiv.classList.add('topic-actions');

        const editBtn = document.createElement('button');
        editBtn.innerHTML = '<i class="fas fa-edit"></i>';
        editBtn.classList.add('btn-icon', 'edit-icon');
        editBtn.title = "Đổi tên Chủ đề";
        editBtn.onclick = (e) => {
            e.stopPropagation();
            suaChuDe(topic.id, topic.name);
        };

        const deleteBtn = document.createElement('button');
        deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
        deleteBtn.classList.add('btn-icon', 'delete-icon');
        deleteBtn.title = "Xóa Chủ đề";
        deleteBtn.onclick = (e) => {
            e.stopPropagation();
            xoaChuDe(topic.id);
        };

        actionDiv.appendChild(editBtn);
        actionDiv.appendChild(deleteBtn);

        li.appendChild(nameSpan);
        li.appendChild(actionDiv);

        li.addEventListener('click', (event) => {
            handleTopicClick(topic.id, topic.name, li);
        });
        topicUl.appendChild(li);
    });

    if (topics.length > 0) {
        const firstTopicElement = topicUl.querySelector('.topic-item');
        if (firstTopicElement) {
            handleTopicClick(topics[0].id, topics[0].name, firstTopicElement);
        }
    }
}

const addTopicBtn = document.getElementById('add-topic-btn');
if (addTopicBtn) {
    addTopicBtn.addEventListener('click', () => {
        const topicName = prompt("Nhập tên Chủ đề mới:");
        if (!topicName || topicName.trim() === "") return;

        fetch(`${API_BASE_URL}/topics`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ name: topicName.trim() })
        })
            .then(async res => {
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || "Lỗi server");
                return data;
            })
            .then(data => {
                alert("✅ " + data.message);
                fetchTopics();
            })
            .catch(err => alert("❌ Lỗi: " + err.message));
    });
}

function suaChuDe(id, oldName) {
    const newName = prompt("Nhập tên mới cho chủ đề:", oldName);
    if (!newName || newName.trim() === "" || newName === oldName) return;

    fetch(`${API_BASE_URL}/topics/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: newName.trim() })
    })
        .then(async res => {
            const data = await res.json();
            if (!res.ok) throw new Error(data.message || "Lỗi server");
            return data;
        })
        .then(data => {
            alert("✅ " + data.message);
            fetchTopics();
        })
        .catch(err => alert("❌ Lỗi: " + err.message));
}

function xoaChuDe(id) {
    showSystemConfirm("Bạn có chắc chắn muốn xóa chủ đề này?\n(Lưu ý: Bạn phải xóa hết Bài học bên trong mới có thể xóa Chủ đề)", () => {
        fetch(`${API_BASE_URL}/topics/${id}`, { method: 'DELETE' })
            .then(async res => {
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || "Lỗi server");
                return data;
            })
            .then(data => {
                alert("✅ " + data.message);
                fetchTopics();
                document.getElementById('current-topic-display').textContent = "Vui lòng chọn Chủ đề để quản lý Bài học...";
                document.getElementById('lesson-ul').innerHTML = '';
                document.getElementById('question-management-area').classList.add('hidden');
                document.getElementById('add-lesson-btn').style.display = 'none';
            })
            .catch(err => alert("❌ Lỗi: " + err.message));
    });
}

function handleTopicClick(topicId, topicName, clickedElement) {
    currentTopicDisplay.textContent = `Chủ đề: ${topicName}`;
    document.querySelectorAll('.topic-item').forEach(item => {
        item.classList.remove('active');
    });
    clickedElement.classList.add('active');

    const lessonUl = document.getElementById('lesson-ul');
    lessonUl.innerHTML = '<li style="list-style: none;">Đang tải Bài học...</li>';

    fetch(`${API_BASE_URL}/lessons/${topicId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(lessons => {
            renderLessons(lessons);
        })
        .catch(error => {
            console.error('Lỗi:', error);
            lessonUl.innerHTML = `<li style="list-style: none; color: var(--wrong-color);">Lỗi tải bài học.</li>`;
        });
    showAddLessonButton(topicId);
}

function renderLessons(lessons) {
    const lessonUl = document.getElementById('lesson-ul');
    lessonUl.innerHTML = '';
    if (lessons.length === 0) {
        lessonUl.innerHTML = '<li style="list-style: none;">Chưa có Bài học nào trong Chủ đề này.</li>';
        return;
    }

    const currentTopicId = document.querySelector('.topic-item.active').dataset.topicId;

    lessons.forEach(lesson => {
        const li = document.createElement('li');
        li.classList.add('lesson-item');
        li.dataset.lessonId = lesson.id;

        const nameSpan = document.createElement('span');
        nameSpan.classList.add('lesson-name');
        if (lesson.is_summary) {
            li.classList.add('summary-lesson');
            nameSpan.textContent = `⭐ ${lesson.name}`;
        } else {
            nameSpan.textContent = lesson.name;
        }

        const actionDiv = document.createElement('div');
        actionDiv.classList.add('lesson-actions');

        const editBtn = document.createElement('button');
        editBtn.innerHTML = '<i class="fas fa-edit"></i>';
        editBtn.classList.add('btn-icon', 'edit-icon');
        editBtn.title = "Đổi tên Bài học";
        editBtn.onclick = (e) => {
            e.stopPropagation();
            suaBaiHoc(lesson.id, lesson.name, currentTopicId);
        };

        const deleteBtn = document.createElement('button');
        deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
        deleteBtn.classList.add('btn-icon', 'delete-icon');
        deleteBtn.title = "Xóa Bài học";
        deleteBtn.onclick = (e) => {
            e.stopPropagation();
            xoaBaiHoc(lesson.id, currentTopicId);
        };

        actionDiv.appendChild(editBtn);
        actionDiv.appendChild(deleteBtn);

        li.appendChild(nameSpan);
        li.appendChild(actionDiv);

        li.addEventListener('click', () => {
            handleLessonClick(lesson.id, lesson.name, li);
        });

        lessonUl.appendChild(li);
    });
}

function suaBaiHoc(id, oldName, topicId) {
    const newName = prompt("Nhập tên mới cho bài học:", oldName);
    if (!newName || newName.trim() === "" || newName === oldName) return;

    fetch(`${API_BASE_URL}/lessons/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ name: newName.trim() })
    })
        .then(async res => {
            const data = await res.json();
            if (!res.ok) throw new Error(data.message || "Lỗi server");
            return data;
        })
        .then(data => {
            alert("✅ " + data.message);
            fetch(`${API_BASE_URL}/lessons/${topicId}`)
                .then(res => res.json())
                .then(lessons => renderLessons(lessons));

            if (currentSelectedLessonId === id) {
                document.getElementById('current-lesson-display').textContent = newName.trim();
            }
        })
        .catch(err => alert("❌ Lỗi: " + err.message));
}

function xoaBaiHoc(id, topicId) {
    showSystemConfirm("Bạn có chắc chắn muốn xóa bài học này không?", () => {
        fetch(`${API_BASE_URL}/lessons/${id}`, { method: 'DELETE' })
            .then(async res => {
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || "Lỗi server");
                return data;
            })
            .then(data => {
                alert("✅ " + data.message);
                fetch(`${API_BASE_URL}/lessons/${topicId}`)
                    .then(res => res.json())
                    .then(lessons => renderLessons(lessons));
                if (currentSelectedLessonId === id) {
                    document.getElementById('question-management-area').classList.add('hidden');
                    currentSelectedLessonId = null;
                }
            })
            .catch(err => alert("❌ Lỗi: " + err.message));
    });
}

function handleLessonClick(lessonId, lessonName, clickedElement) {
    currentSelectedLessonId = lessonId;
    console.log("Đã chọn bài học ID:", currentSelectedLessonId);
    currentLessonDisplay.textContent = lessonName;
    questionManagementArea.classList.remove('hidden');
    document.querySelectorAll('.lesson-item').forEach(item => {
        item.classList.remove('active');
    });
    clickedElement.classList.add('active');
    fetchQuestions(lessonId);
}

function fetchQuestions(lessonId) {
    const questionListArea = document.getElementById('question-list-area');
    questionListArea.innerHTML = 'Đang tải câu hỏi...';
    fetch(`${API_BASE_URL}/questions/${lessonId}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(questions => {
            renderQuestions(questions);
        })
        .catch(error => {
            console.error('Lỗi:', error);
            questionListArea.innerHTML = `<p style="color: var(--wrong-color);">Lỗi tải câu hỏi. Server có đang chạy không?</p>`;
        });
}

function showAddLessonButton(topicId) {
    const addLessonBtn = document.getElementById('add-lesson-btn');
    if (!addLessonBtn) return;

    addLessonBtn.style.display = 'block';
    addLessonBtn.onclick = () => {
        const lessonName = prompt("Nhập tên Bài học mới cho chủ đề này:");
        if (!lessonName || lessonName.trim() === "") return;

        fetch(`${API_BASE_URL}/lessons`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                topic_id: topicId,
                name: lessonName,
                is_summary: 0
            })
        })
            .then(async res => {
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || "Lỗi server");
                return data;
            })
            .then(data => {
                alert("✅ " + data.message);
                fetch(`${API_BASE_URL}/lessons/${topicId}`)
                    .then(res => res.json())
                    .then(lessons => renderLessons(lessons));
            })
            .catch(err => {
                console.error(err);
                alert("❌ Lỗi: " + err.message);
            });
    };
}

addBtn.addEventListener('click', () => {
    delete form.dataset.editId;
    form.reset();
    document.querySelector('.modal-header-custom h3').textContent = "Thêm Câu Hỏi Mới";
    addModal.classList.remove('hidden');
});

function renderQuestions(questions) {
    const questionListArea = document.getElementById('question-list-area');
    questionListArea.innerHTML = '';

    if (questions.length === 0) {
        questionListArea.innerHTML = '<p>Chưa có câu hỏi nào.</p>';
        return;
    }

    questions.forEach(q => {
        const card = document.createElement('div');
        card.className = 'question-card';
        card.style = "border: 1px solid #3689e7; padding: 15px; margin-bottom: 10px; border-radius: 8px; background: #0e0543; color: white;";

        card.innerHTML = `
            <p><strong>[${q.difficulty.toUpperCase()}] ID ${q.id}:</strong> ${q.question_text}</p>
            <div style="margin-top: 10px;">
                <button class="btn edit-btn" style="background: white; color: black; border: none; padding: 5px 15px; cursor: pointer; border-radius: 5px; font-weight: bold;">Sửa</button>
                <button class="btn delete-btn" style="background: #d71515; color: white; border: none; padding: 5px 15px; cursor: pointer; border-radius: 5px; margin-left: 10px;">Xóa</button>
            </div>
        `;

        card.querySelector('.edit-btn').onclick = () => {
            addModal.classList.remove('hidden');
            document.querySelector('.modal-header-custom h3').textContent = "Sửa Câu Hỏi ID: " + q.id;
            form.dataset.editId = q.id;
            document.getElementById('q-text').value = q.question_text;
            document.getElementById('q-opt1').value = q.options[0];
            document.getElementById('q-opt2').value = q.options[1];
            document.getElementById('q-opt3').value = q.options[2];
            document.getElementById('q-opt4').value = q.options[3];
            document.getElementById('q-diff').value = q.difficulty;
            document.getElementById('q-correct').value = q.correct_answer;
        };

        card.querySelector('.delete-btn').onclick = () => xoaCauHoi(q.id);
        questionListArea.appendChild(card);
    });
}

function xoaCauHoi(id) {
    showSystemConfirm("Bạn có chắc chắn muốn xóa câu hỏi ID: " + id + "?", () => {
        fetch(`${API_BASE_URL}/questions/${id}`, { method: 'DELETE' })
            .then(res => res.json())
            .then(data => {
                alert("✅ " + data.message);
                fetchQuestions(currentSelectedLessonId);
            })
            .catch(err => alert("❌ Lỗi kết nối server."));
    });
}
form.addEventListener('submit', (e) => {
    e.preventDefault();

    const editId = form.dataset.editId;
    const url = editId ? `${API_BASE_URL}/questions/${editId}` : `${API_BASE_URL}/questions`;
    const method = editId ? 'PUT' : 'POST';

    const data = {
        lesson_id: currentSelectedLessonId,
        question_text: document.getElementById('q-text').value,
        options: [
            document.getElementById('q-opt1').value,
            document.getElementById('q-opt2').value,
            document.getElementById('q-opt3').value,
            document.getElementById('q-opt4').value
        ],
        correct_answer: document.getElementById('q-correct').value,
        difficulty: document.getElementById('q-diff').value
    };

    fetch(url, {
        method: method,
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
        .then(res => res.json())
        .then(result => {
            alert("✅ " + result.message);
            addModal.classList.add('hidden');
            form.reset();
            delete form.dataset.editId;
            document.querySelector('.modal-header-custom h3').textContent = "Thêm Câu Hỏi Mới";
            fetchQuestions(currentSelectedLessonId);
        })
        .catch(err => alert("❌ Lỗi: " + err));
});

closeBtn.addEventListener('click', () => {
    addModal.classList.add('hidden');
});

window.gracefulRestart = function () {
    document.getElementById('final-result-overlay').style.display = 'none';

    const gameBox = document.querySelector(".game-box");
    const startBox = document.querySelector(".start-box");

    gameBox.classList.remove("show");
    gameBox.classList.add("hidden");

    startBox.classList.remove("hidden");
    startBox.classList.remove("show");

    clearInterval(timerId);
    const timerUI = document.querySelector(".timer");
    timerUI.innerHTML = "60";
    timerUI.classList.remove("less-time");

    if (inGamePlay) { inGamePlay.pause(); inGamePlay.currentTime = 0; }
    if (OutTime) { OutTime.pause(); OutTime.currentTime = 0; }
    if (Win) { Win.pause(); Win.currentTime = 0; }

    MainThemePlay.currentTime = 0;
    MainThemePlay.play();

};

const tabTopicsBtn = document.getElementById('tab-topics-btn');
const tabStudentsBtn = document.getElementById('tab-students-btn');
const adminTopicContent = document.getElementById('admin-topic-content');
const adminStudentContent = document.getElementById('admin-student-content');

let currentSelectedClassId = null;

function resetAllAdminTabs() {
    if (adminTopicContent) adminTopicContent.classList.add('hidden');
    if (adminStudentContent) adminStudentContent.classList.add('hidden');

    const adminResultsContent = document.getElementById('admin-results-content');
    if (adminResultsContent) adminResultsContent.classList.add('hidden');

    if (tabTopicsBtn) { tabTopicsBtn.style.background = "transparent"; tabTopicsBtn.style.color = "gold"; }
    if (tabStudentsBtn) { tabStudentsBtn.style.background = "transparent"; tabStudentsBtn.style.color = "gold"; }

    const tabResBtn = document.getElementById('tab-results-btn');
    if (tabResBtn) { tabResBtn.style.background = "transparent"; tabResBtn.style.color = "#11c466"; }
}

if (tabTopicsBtn && tabStudentsBtn) {
    tabTopicsBtn.addEventListener('click', () => {
        resetAllAdminTabs();
        tabTopicsBtn.style.background = "gold";
        tabTopicsBtn.style.color = "black";
        adminTopicContent.classList.remove('hidden');
    });

    tabStudentsBtn.addEventListener('click', () => {
        resetAllAdminTabs();
        tabStudentsBtn.style.background = "gold";
        tabStudentsBtn.style.color = "black";
        adminStudentContent.classList.remove('hidden');
        fetchClasses();
    });
}
const classUl = document.getElementById('class-ul');
const addClassBtn = document.getElementById('add-class-btn');
const currentClassDisplay = document.getElementById('current-class-display');
const studentManagementArea = document.getElementById('student-management-area');
const studentListArea = document.getElementById('student-list-area');

function fetchClasses() {
    if (!currentTeacher) return;

    fetch(`${API_BASE_URL}/classes/teacher/${currentTeacher.id}`)
        .then(res => res.json())
        .then(classes => {
            classUl.innerHTML = '';

            if (classes.length === 0) {
                classUl.innerHTML = '<li style="list-style: none;">Chưa có Lớp học nào.</li>';
                return;
            }

            classes.forEach(cls => {
                const li = document.createElement('li');
                li.classList.add('topic-item'); // Dùng chung class với chủ đề để lấy CSS đẹp

                // 1. Tên Lớp
                const nameSpan = document.createElement('span');
                nameSpan.classList.add('topic-name');
                nameSpan.textContent = `🏫 Lớp ${cls.class_name}`;

                // 2. Khu vực chứa nút bấm
                const actionDiv = document.createElement('div');
                actionDiv.classList.add('topic-actions');

                // Nút Sửa
                const editBtn = document.createElement('button');
                editBtn.innerHTML = '<i class="fas fa-edit"></i>';
                editBtn.classList.add('btn-icon', 'edit-icon');
                editBtn.title = "Đổi tên Lớp";
                editBtn.onclick = (e) => {
                    e.stopPropagation(); // Ngăn việc vừa bấm nút vừa click mở danh sách HS
                    suaLop(cls.id, cls.class_name);
                };

                // Nút Xóa
                const deleteBtn = document.createElement('button');
                deleteBtn.innerHTML = '<i class="fas fa-trash"></i>';
                deleteBtn.classList.add('btn-icon', 'delete-icon');
                deleteBtn.title = "Xóa Lớp";
                deleteBtn.onclick = (e) => {
                    e.stopPropagation();
                    xoaLop(cls.id);
                };

                actionDiv.appendChild(editBtn);
                actionDiv.appendChild(deleteBtn);

                li.appendChild(nameSpan);
                li.appendChild(actionDiv);

                // 3. Sự kiện Click vào dòng Lớp học để xem Học sinh
                li.addEventListener('click', () => {
                    document.querySelectorAll('#class-ul .topic-item').forEach(item => item.classList.remove('active'));
                    li.classList.add('active');

                    currentSelectedClassId = cls.id;
                    currentClassDisplay.textContent = `Danh sách học sinh lớp: ${cls.class_name}`;
                    studentManagementArea.classList.remove('hidden');

                    fetchStudents(cls.id);
                });

                classUl.appendChild(li);
            });
        })
        .catch(err => console.error("Lỗi:", err));
}

// ===================================
// HÀM XỬ LÝ SỬA VÀ XÓA LỚP
// ===================================
window.suaLop = function (id, oldName) {
    const newName = prompt("Nhập tên mới cho Lớp học:", oldName);
    if (!newName || newName.trim() === "" || newName === oldName) return;

    fetch(`${API_BASE_URL}/classes/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ class_name: newName.trim() })
    })
        .then(async res => {
            const data = await res.json();
            if (!res.ok) throw new Error(data.message);
            return data;
        })
        .then(data => {
            alert("✅ " + data.message);
            fetchClasses(); // Tải lại danh sách lớp bên trái

            // Nếu đang mở đúng lớp đó, đổi luôn tên hiển thị ở bảng bên phải
            if (currentSelectedClassId === id) {
                currentClassDisplay.textContent = `Danh sách học sinh lớp: ${newName.trim()}`;
            }
        })
        .catch(err => alert("❌ " + err.message));
};

window.xoaLop = function (id) {
    showSystemConfirm("Bạn có chắc chắn muốn xóa Lớp học này không?\n(Lưu ý: Bạn phải xóa hết Học sinh trong lớp mới có thể xóa Lớp)", () => {
        fetch(`${API_BASE_URL}/classes/${id}`, { method: 'DELETE' })
            .then(async res => {
                const data = await res.json();
                if (!res.ok) throw new Error(data.message);
                return data;
            })
            .then(data => {
                alert("✅ " + data.message);
                fetchClasses(); // Tải lại danh sách lớp

                // Nếu xóa đúng lớp đang mở, ẩn luôn bảng Học sinh bên phải đi
                if (currentSelectedClassId === id) {
                    studentManagementArea.classList.add('hidden');
                    currentSelectedClassId = null;
                }
            })
            .catch(err => alert("❌ " + err.message));
    });
};

if (addClassBtn) {
    addClassBtn.addEventListener('click', () => {
        const className = prompt("Nhập tên Lớp mới (VD: 10A1):");
        if (!className || className.trim() === "") return;

        fetch(`${API_BASE_URL}/classes`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                class_name: className.trim(),
                teacher_id: currentTeacher.id
            })
        })
            .then(res => res.json())
            .then(data => {
                if (data.message.includes('Lỗi')) alert(data.message);
                else {
                    alert("✅ " + data.message);
                    fetchClasses();
                }
            });
    });
}

const addStudentBtn = document.getElementById('add-student-btn');
if (addStudentBtn) {
    addStudentBtn.addEventListener('click', () => {
        if (!currentSelectedClassId) {
            return alert("⚠️ Vui lòng chọn Lớp học trước khi thêm học sinh!");
        }

        const stt = prompt("Nhập Số Thứ Tự (STT) của học sinh:");
        if (!stt || isNaN(stt)) return;

        const name = prompt("Nhập Họ và Tên học sinh:");
        if (!name || name.trim() === "") return;

        const pass = prompt("Nhập Mật khẩu đăng nhập (VD: ddmmyyyy):");
        if (!pass || pass.trim() === "") return;

        fetch(`${API_BASE_URL}/students`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                class_id: currentSelectedClassId,
                student_number: parseInt(stt),
                full_name: name.trim(),
                password: pass.trim()
            })
        })
            .then(res => res.json())
            .then(data => {
                if (data.message.includes('Lỗi')) {
                    alert("❌ " + data.message);
                } else {
                    alert("✅ " + data.message);
                    fetchStudents(currentSelectedClassId);
                }
            })
            .catch(err => alert("❌ Lỗi kết nối Server!"));
    });
}
let currentStudentsData = [];
let currentSortMode = 'stt_asc';

function fetchStudents(classId) {
    studentListArea.innerHTML = '<p>Đang tải danh sách học sinh...</p>';
    fetch(`${API_BASE_URL}/students/${classId}`)
        .then(res => res.json())
        .then(students => {
            currentStudentsData = students;
            renderStudentsTable(classId);
        })
        .catch(err => console.error("Lỗi:", err));
}

function renderStudentsTable(classId) {
    studentListArea.innerHTML = '';
    if (currentStudentsData.length === 0) {
        studentListArea.innerHTML = '<p style="color: #aaa;">Lớp này chưa có học sinh nào.</p>';
        return;
    }

    if (currentSortMode === 'stt_asc') currentStudentsData.sort((a, b) => a.student_number - b.student_number);
    else if (currentSortMode === 'stt_desc') currentStudentsData.sort((a, b) => b.student_number - a.student_number);
    else if (currentSortMode === 'name_asc') currentStudentsData.sort((a, b) => a.full_name.localeCompare(b.full_name, 'vi'));
    else if (currentSortMode === 'name_desc') currentStudentsData.sort((a, b) => b.full_name.localeCompare(a.full_name, 'vi'));

    let toolsHTML = `
        <div style="margin-bottom: 10px; background: rgba(0,0,0,0.3); padding: 10px; border-radius: 8px;">
            <span style="color: gold; font-weight: bold; margin-right: 15px;">🔄 Sắp xếp:</span>
            <button onclick="changeStudentSort('name_asc', ${classId})" class="btn" style="background: ${currentSortMode === 'name_asc' ? 'gold' : '#3689e7'}; color: ${currentSortMode === 'name_asc' ? 'black' : 'white'}; padding: 5px 10px; margin-right: 5px;">Tên A-Z ↓</button>
            <button onclick="changeStudentSort('name_desc', ${classId})" class="btn" style="background: ${currentSortMode === 'name_desc' ? 'gold' : '#3689e7'}; color: ${currentSortMode === 'name_desc' ? 'black' : 'white'}; padding: 5px 10px; margin-right: 5px;">Tên Z-A ↑</button>
            <button onclick="changeStudentSort('stt_asc', ${classId})" class="btn" style="background: ${currentSortMode === 'stt_asc' ? 'gold' : '#3689e7'}; color: ${currentSortMode === 'stt_asc' ? 'black' : 'white'}; padding: 5px 10px; margin-right: 5px;">STT (1-9) ↓</button>
            <button onclick="changeStudentSort('stt_desc', ${classId})" class="btn" style="background: ${currentSortMode === 'stt_desc' ? 'gold' : '#3689e7'}; color: ${currentSortMode === 'stt_desc' ? 'black' : 'white'}; padding: 5px 10px;">STT (9-1) ↑</button>
        </div>
    `;

    let tableHTML = `
        <table style="width: 100%; border-collapse: collapse; background: #0e0543; color: white;">
            <tr style="background: #2569b6;">
                <th style="padding: 10px; border: 1px solid #3689e7;">STT</th>
                <th style="padding: 10px; border: 1px solid #3689e7;">Họ và Tên</th>
                <th style="padding: 10px; border: 1px solid #3689e7;">Mật khẩu</th>
                <th style="padding: 10px; border: 1px solid #3689e7; width: 100px;">Hành động</th>
            </tr>
    `;

    currentStudentsData.forEach(st => {
        tableHTML += `
            <tr>
                <td style="padding: 8px; border: 1px solid #3689e7; text-align: center; color: gold; font-weight: bold;">${st.student_number}</td>
                <td style="padding: 8px; border: 1px solid #3689e7;">${st.full_name}</td>
                <td style="padding: 8px; border: 1px solid #3689e7; text-align: center; color: #11c466;">${st.password}</td>
                <td style="padding: 8px; border: 1px solid #3689e7; text-align: center;">
                    <button onclick="suaHocSinh(${st.id}, ${st.student_number}, \`${st.full_name}\`, \`${st.password}\`, ${classId})" title="Sửa" style="background: white; color: black; border: none; padding: 5px 10px; cursor: pointer; border-radius: 5px; margin-right: 5px;"><i class="fas fa-edit"></i></button>
                    <button onclick="xoaHocSinh(${st.id}, ${classId})" title="Xóa" style="background: #d71515; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 5px;"><i class="fas fa-trash"></i></button>
                </td>
            </tr>
        `;
    });
    tableHTML += '</table>';

    studentListArea.innerHTML = toolsHTML + tableHTML;
}

window.changeStudentSort = function (mode, classId) {
    currentSortMode = mode;
    renderStudentsTable(classId);
};

window.xoaHocSinh = function (id, classId) {
    showSystemConfirm("Bạn có chắc chắn muốn xóa học sinh này không?", () => {
        fetch(`${API_BASE_URL}/students/${id}`, { method: 'DELETE' })
            .then(res => res.json())
            .then(data => {
                alert("✅ " + data.message);
                fetchStudents(classId);
            })
            .catch(err => alert("❌ Lỗi Server"));
    });
};

window.suaHocSinh = function (id, oldStt, oldName, oldPass, classId) {
    document.getElementById('edit-student-id').value = id;
    document.getElementById('edit-student-stt').value = oldStt;
    document.getElementById('edit-student-name').value = oldName;
    document.getElementById('edit-student-pass').value = oldPass;

    document.getElementById('student-form').dataset.classId = classId;

    document.getElementById('student-modal').style.display = 'flex';
};

const closeStudentModalBtn = document.getElementById('close-student-modal');
if (closeStudentModalBtn) {
    closeStudentModalBtn.addEventListener('click', () => {
        document.getElementById('student-modal').style.display = 'none';
    });
}

const studentFormEl = document.getElementById('student-form');
if (studentFormEl) {
    studentFormEl.addEventListener('submit', (e) => {
        e.preventDefault();

        const id = document.getElementById('edit-student-id').value;
        const classId = document.getElementById('student-form').dataset.classId;
        const newStt = document.getElementById('edit-student-stt').value;
        const newName = document.getElementById('edit-student-name').value;
        const newPass = document.getElementById('edit-student-pass').value;

        fetch(`${API_BASE_URL}/students/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                student_number: parseInt(newStt),
                full_name: newName.trim(),
                password: newPass.trim()
            })
        })
            .then(res => res.json())
            .then(data => {
                alert("✅ " + data.message);
                document.getElementById('student-modal').style.display = 'none';
                fetchStudents(classId);
            })
            .catch(err => alert("❌ Lỗi kết nối Server!"));
    });
}

const modeHomeBtn = document.getElementById('mode-home-btn');
const homeLoginForm = document.getElementById('home-login-form');
const homeClassSelect = document.getElementById('home-class-select');
const loginHomeBtn = document.getElementById('login-home-btn');

let currentHomeStudent = null;
let isHomeMode = false;

const studentFormArea = document.getElementById('student-start-game');
let changePassBtn = document.getElementById('btn-open-change-pass');
let logoutStudentBtn = document.getElementById('btn-student-logout');

if (studentFormArea) {
    if (!changePassBtn) {
        changePassBtn = document.createElement('button');
        changePassBtn.id = "btn-open-change-pass";
        changePassBtn.innerHTML = "🔑 Đổi mật khẩu cá nhân";
        changePassBtn.style.cssText = "background: #e67e22; color: white; padding: 10px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; margin-top: 15px; width: 100%; display: none;";
        studentFormArea.appendChild(changePassBtn);

        changePassBtn.addEventListener('click', (e) => {
            e.preventDefault();
            document.getElementById('student-change-pass-modal').style.display = 'flex';
            document.getElementById('change-pass-form').reset();
        });
    }

    if (!logoutStudentBtn) {
        logoutStudentBtn = document.createElement('button');
        logoutStudentBtn.id = "btn-student-logout";
        logoutStudentBtn.innerHTML = "🚪 Đăng xuất";
        logoutStudentBtn.style.cssText = "background: #d71515; color: white; padding: 10px; border: none; border-radius: 5px; font-weight: bold; cursor: pointer; margin-top: 10px; width: 100%; display: none;";
        studentFormArea.appendChild(logoutStudentBtn);

        logoutStudentBtn.addEventListener('click', (e) => {
            e.preventDefault();
            currentHomeStudent = null;
            isHomeMode = false;
            document.body.classList.remove('home-mode-active');

            document.querySelector('.mode-selection').style.display = '';
            document.querySelector('.auth-box h2').textContent = "Đăng Nhập Hệ Thống";

            changePassBtn.style.display = 'none';
            logoutStudentBtn.style.display = 'none';

            switchModeAuth('home');
        });
    }
}

function switchModeAuth(mode) {
    modeStudentBtn.classList.remove("active-mode");
    modeTeacherBtn.classList.remove("active-mode");
    modeHomeBtn.classList.remove("active-mode");

    studentStartGameForm.classList.add("hidden");
    teacherLoginForm.classList.add("hidden");
    homeLoginForm.classList.add("hidden");

    if (changePassBtn) changePassBtn.style.display = 'none';
    if (logoutStudentBtn) logoutStudentBtn.style.display = 'none';

    if (mode === 'student') {
        modeStudentBtn.classList.add("active-mode");
        studentStartGameForm.classList.remove("hidden");
        isHomeMode = false;
        currentHomeStudent = null;
    } else if (mode === 'teacher') {
        modeTeacherBtn.classList.add("active-mode");
        teacherLoginForm.classList.remove("hidden");
    } else if (mode === 'home') {
        modeHomeBtn.classList.add("active-mode");
        homeLoginForm.classList.remove("hidden");
        loadClassesForHome();
    }
}

modeStudentBtn.onclick = () => switchModeAuth('student');
modeTeacherBtn.onclick = () => switchModeAuth('teacher');
modeHomeBtn.onclick = () => switchModeAuth('home');

function loadClassesForHome() {
    fetch(`${API_BASE_URL}/classes`)
        .then(res => res.json())
        .then(classes => {
            homeClassSelect.innerHTML = '<option value="">-- Chọn Lớp --</option>';
            classes.forEach(cls => {
                const teacherName = cls.teacher_name ? ` (GV: ${cls.teacher_name})` : '';
                homeClassSelect.innerHTML += `<option value="${cls.id}">${cls.class_name}${teacherName}</option>`;
            });
        })
        .catch(err => console.error("Lỗi:", err));
}

loginHomeBtn.addEventListener('click', () => {
    const classId = homeClassSelect.value;
    const stt = document.getElementById('home-stt').value.trim();
    const pwd = document.getElementById('home-password').value.trim();

    if (!classId || !stt || !pwd) return alert("Vui lòng điền đầy đủ thông tin!");

    fetch(`${API_BASE_URL}/students/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ class_id: classId, student_number: stt, password: pwd })
    })
        .then(res => res.json())
        .then(data => {
            if (data.student) {
                alert(`✅ Đăng nhập thành công! Xin chào ${data.student.full_name}.`);
                currentHomeStudent = data.student;
                isHomeMode = true;
                document.body.classList.add('home-mode-active');

                homeLoginForm.classList.add('hidden');
                document.querySelector('.mode-selection').style.display = 'none';
                document.querySelector('.auth-box h2').textContent = `Xin chào, ${data.student.full_name}`;
                studentStartGameForm.classList.remove('hidden');

                if (changePassBtn) changePassBtn.style.display = 'block';
                if (logoutStudentBtn) logoutStudentBtn.style.display = 'block';
            } else {
                alert("❌ " + data.message);
            }
        })
        .catch(err => console.error(err));
});

const closePassModalBtn = document.getElementById('close-change-pass-modal');
if (closePassModalBtn) {
    closePassModalBtn.addEventListener('click', () => {
        document.getElementById('student-change-pass-modal').style.display = 'none';
    });
}

const changePassFormObj = document.getElementById('change-pass-form');
if (changePassFormObj) {
    changePassFormObj.addEventListener('submit', (e) => {
        e.preventDefault();

        const oldPass = document.getElementById('old-pass-input').value.trim();
        const newPass = document.getElementById('new-pass-input').value.trim();

        if (oldPass === newPass) return alert("❌ Mật khẩu mới phải khác mật khẩu hiện tại!");

        fetch(`${API_BASE_URL}/student-change-password`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                student_id: currentHomeStudent.id,
                old_password: oldPass,
                new_password: newPass
            })
        })
            .then(async res => {
                const data = await res.json();
                if (!res.ok) throw new Error(data.message || "Lỗi server");
                return data;
            })
            .then(data => {
                alert("✅ " + data.message);
                document.getElementById('student-change-pass-modal').style.display = 'none';
                currentHomeStudent.password = newPass;
                document.getElementById('change-pass-form').reset();
            })
            .catch(err => alert("❌ Lỗi: " + err.message));
    });
}
const tabResultsBtn = document.getElementById('tab-results-btn');
const adminResultsContent = document.getElementById('admin-results-content');
let currentResultsData = [];

if (tabResultsBtn) {
    tabResultsBtn.addEventListener('click', () => {
        resetAllAdminTabs();
        tabResultsBtn.style.background = "#11c466";
        tabResultsBtn.style.color = "black";
        adminResultsContent.classList.remove('hidden');

        fetchResultsData();
    });
}

function fetchResultsData() {
    if (!currentTeacher) return;

    const endpoint = currentTeacher.username === 'admin'
        ? `${API_BASE_URL}/results/all`
        : `${API_BASE_URL}/results/teacher/${currentTeacher.id}`;

    studentListArea.innerHTML = '<p>Đang tải dữ liệu kết quả...</p>';

    fetch(endpoint)
        .then(res => {
            if (!res.ok) throw new Error('Không thể tải dữ liệu');
            return res.json();
        })
        .then(data => {
            currentResultsData = Array.isArray(data) ? data : (data.results || []);
            renderResultsTable();
        })
        .catch(err => {
            console.error("Lỗi tải kết quả:", err);
            document.getElementById('results-list-area').innerHTML = '<p style="color: red;">❌ Không thể tải kết quả. Vui lòng kiểm tra Server.</p>';
        });
}
let currentSortType = 'time_desc';

window.renderResultsTable = function () {
    const area = document.getElementById('results-list-area');
    const searchInput = document.getElementById('search-results-input');

    const searchTerm = searchInput ? searchInput.value.toLowerCase() : "";

    let filteredData = currentResultsData.filter(r => {
        const name = (r.full_name || 'Ẩn danh').toLowerCase();
        const className = (r.class_name || '').toLowerCase();
        const lessonName = (r.lesson_name || '').toLowerCase();
        return name.includes(searchTerm) || className.includes(searchTerm) || lessonName.includes(searchTerm);
    });

    filteredData.sort((a, b) => {
        if (currentSortType === 'score_desc') return b.score - a.score;
        if (currentSortType === 'score_asc') return a.score - b.score;
        if (currentSortType === 'time_desc') return new Date(b.play_time) - new Date(a.play_time);
        if (currentSortType === 'time_asc') return new Date(a.play_time) - new Date(b.play_time);
        return 0;
    });

    let html = `
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; flex-wrap: wrap; gap: 10px;">
            <div style="display: flex; gap: 10px; align-items: center;">
                <input type="text" id="search-results-input" placeholder="🔍 Tìm Tên, Lớp hoặc Bài học..." 
                       value="${searchTerm}" onkeyup="renderResultsTable()" 
                       style="padding: 10px; border-radius: 5px; border: 1px solid #3689e7; background: #0e0543; color: white; width: 250px;">
                
                <select id="sort-type-select" onchange="changeSort(this.value)" 
                        style="padding: 9px; border-radius: 5px; background: #2569b6; color: white; border: none; cursor: pointer;">
                    <option value="time_desc" ${currentSortType === 'time_desc' ? 'selected' : ''}>📅 Mới nhất</option>
                    <option value="time_asc" ${currentSortType === 'time_asc' ? 'selected' : ''}>📅 Cũ nhất (Xong sớm)</option>
                    <option value="score_desc" ${currentSortType === 'score_desc' ? 'selected' : ''}>🏆 Điểm cao nhất</option>
                    <option value="score_asc" ${currentSortType === 'score_asc' ? 'selected' : ''}>📉 Điểm thấp nhất</option>
                </select>
            </div>
            
            <div style="display: flex; gap: 8px;">
                <button onclick="exportResultsToExcel()" style="background: #11c466; color: white; border: none; padding: 10px 15px; cursor: pointer; border-radius: 5px; font-weight: bold;">📥 Xuất Excel</button>
                <button onclick="deleteSelectedResults()" style="background: #e67e22; color: white; border: none; padding: 10px 15px; cursor: pointer; border-radius: 5px; font-weight: bold;">❌ Xóa đã chọn</button>
                <button onclick="clearAllResults()" style="background: #d71515; color: white; border: none; padding: 10px 15px; cursor: pointer; border-radius: 5px; font-weight: bold;">🗑️ Xóa sạch</button>
            </div>
        </div>

        <table id="table-to-export" style="width:100%; border-collapse: collapse; color: white; background: #0e0543;">
            <tr style="background: #2569b6;">
                <th style="padding:10px; border:1px solid #3689e7; width: 40px;"><input type="checkbox" onclick="toggleAllResults(this)"></th>
                <th style="padding:10px; border:1px solid #3689e7;">Thời gian</th>
                <th style="padding:10px; border:1px solid #3689e7;">Lớp</th>
                <th style="padding:10px; border:1px solid #3689e7;">Học Sinh</th>
                <th style="padding:10px; border:1px solid #3689e7;">Bài Học</th>
                <th style="padding:10px; border:1px solid #3689e7;">Câu đúng</th>
                <th style="padding:10px; border:1px solid #3689e7;">Điểm</th>
            </tr>
    `;

    filteredData.forEach(r => {
        html += `
            <tr>
                <td style="padding:8px; border:1px solid #3689e7; text-align:center;"><input type="checkbox" class="result-checkbox" value="${r.id}"></td>
                <td style="padding:8px; border:1px solid #3689e7; text-align:center;">${new Date(r.play_time).toLocaleString('vi-VN')}</td>
                <td style="padding:8px; border:1px solid #3689e7; text-align:center; color: #11c466; font-weight: bold;">${r.class_name || '-'}</td>
                <td style="padding:8px; border:1px solid #3689e7;">${r.full_name || '(Ẩn danh)'}</td>
                <td style="padding:8px; border:1px solid #3689e7;">${r.lesson_name}</td>
                <td style="padding:8px; border:1px solid #3689e7; text-align:center;">${r.correct_answers}</td>
                <td style="padding:8px; border:1px solid #3689e7; text-align:center; color: gold; font-weight:bold;">${parseFloat(r.score).toFixed(1)}</td>
            </tr>
        `;
    });

    html += '</table>';
    area.innerHTML = html;

    const input = document.getElementById('search-results-input');
    if (input && searchTerm !== "") {
        input.focus();
        input.setSelectionRange(input.value.length, input.value.length);
    }
};

window.exportResultsToExcel = function () {
    const searchInput = document.getElementById('search-results-input');
    const searchTerm = searchInput ? searchInput.value.toLowerCase() : "";

    const filtered = currentResultsData.filter(r => {
        const name = (r.full_name || 'Ẩn danh').toLowerCase();
        const className = (r.class_name || '').toLowerCase();
        const lessonName = (r.lesson_name || '').toLowerCase();
        return name.includes(searchTerm) || className.includes(searchTerm) || lessonName.includes(searchTerm);
    });

    if (filtered.length === 0) return alert("⚠️ Không có dữ liệu để xuất!");

    const excelData = filtered.map(r => ({
        "Thời Gian": new Date(r.play_time).toLocaleString('vi-VN'),
        "Lớp": r.class_name || '-',
        "Học Sinh": r.full_name || 'Ẩn danh',
        "Bài Học": r.lesson_name,
        "Số Câu Đúng": r.correct_answers,
        "Điểm Số": parseFloat(r.score).toFixed(1)
    }));

    const worksheet = XLSX.utils.json_to_sheet(excelData);
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, "KetQuaHocTap");

    const fileName = `KetQua_${searchTerm || 'TatCa'}_${new Date().getTime()}.xlsx`;
    XLSX.writeFile(workbook, fileName);
};

window.changeSort = function (val) {
    currentSortType = val;
    renderResultsTable();
};
window.filterResults = function (term) {
    renderResultsTable(term);
};

window.toggleAllResults = function (source) {
    const checkboxes = document.querySelectorAll('.result-checkbox');
    checkboxes.forEach(cb => cb.checked = source.checked);
};

window.deleteSelectedResults = function () {
    const checkboxes = document.querySelectorAll('.result-checkbox:checked');
    const ids = Array.from(checkboxes).map(cb => parseInt(cb.value));

    if (ids.length === 0) return alert("⚠️ Vui lòng tick chọn ít nhất 1 kết quả để xóa!");

    showSystemConfirm(`Bạn có chắc muốn xóa ${ids.length} kết quả đã chọn?`, () => {
        fetch(`${API_BASE_URL}/results/bulk-delete`, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ ids: ids })
        })
            .then(res => res.json())
            .then(data => {
                alert("✅ " + data.message);
                fetchResultsData();
            })
            .catch(err => alert("❌ Lỗi kết nối Server!"));
    });
};

window.clearAllResults = function () {
    showSystemConfirm("CẢNH BÁO: Xóa TOÀN BỘ lịch sử thi đấu của hệ thống? Hành động này không thể hoàn tác!", () => {
        fetch(`${API_BASE_URL}/results/clear`, { method: 'DELETE' })
            .then(res => res.json())
            .then(data => {
                alert("✅ " + data.message);
                fetchResultsData();
            })
            .catch(err => alert("❌ Lỗi: Không thể kết nối tới Server"));
    });
};
const importExcelBtn = document.getElementById('import-excel-btn');
const excelFileInput = document.getElementById('excel-file-input');

if (importExcelBtn && excelFileInput) {
    importExcelBtn.addEventListener('click', () => {
        if (!currentSelectedClassId) {
            return alert("Vui lòng chọn Lớp trước khi nhập danh sách!");
        }
        excelFileInput.click();
    });

    excelFileInput.addEventListener('change', (e) => {
        const file = e.target.files[0];
        if (!file) return;

        const reader = new FileReader();
        reader.onload = function (event) {
            const data = new Uint8Array(event.target.result);
            const workbook = XLSX.read(data, { type: 'array' });

            const firstSheetName = workbook.SheetNames[0];
            const worksheet = workbook.Sheets[firstSheetName];

            const json = XLSX.utils.sheet_to_json(worksheet, { header: 1 });

            let studentsData = [];

            for (let i = 1; i < json.length; i++) {
                let row = json[i];

                if (row && row.length >= 2 && row[0] != null && row[1] != null) {
                    let stt = parseInt(row[0]);
                    let name = row[1].toString().trim();

                    let dob = row[2] ? row[2].toString() : '123456';

                    let pass = dob.replace(/[-/]/g, '');

                    if (!isNaN(stt) && name !== "") {
                        studentsData.push({
                            student_number: stt,
                            full_name: name,
                            password: pass
                        });
                    }
                }
            }

            if (studentsData.length === 0) {
                excelFileInput.value = '';
                return alert("❌ File Excel trống hoặc sai cấu trúc (Cột 1: STT, Cột 2: Họ Tên, Cột 3: Ngày sinh).");
            }

            fetch(`${API_BASE_URL}/students/bulk`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({
                    class_id: currentSelectedClassId,
                    students: studentsData
                })
            })
                .then(res => res.json())
                .then(data => {
                    alert(data.message.includes('Lỗi') ? "❌ " + data.message : "✅ " + data.message);
                    fetchStudents(currentSelectedClassId);
                    excelFileInput.value = '';
                })
                .catch(err => {
                    console.error(err);
                    alert("❌ Lỗi kết nối tới Server.");
                    excelFileInput.value = '';
                });
        };

        reader.readAsArrayBuffer(file);
    });
}

// ==========================================
// TÍNH NĂNG MỚI: QUẢN LÝ VÀ HỒ SƠ GIÁO VIÊN
// ==========================================
const adminTeacherContent = document.getElementById('admin-teacher-content');
const createTeacherBtn = document.getElementById('create-teacher-btn');
const tabTeachersBtn = document.getElementById('tab-teachers-btn');
const teacherProfileBtn = document.getElementById('teacher-profile-btn');

// Mở rộng hàm resetAllAdminTabs gốc
const originalResetAllAdminTabs = window.resetAllAdminTabs;
window.resetAllAdminTabs = function () {
    if (originalResetAllAdminTabs) originalResetAllAdminTabs();
    if (adminTeacherContent) adminTeacherContent.classList.add('hidden');
    if (tabTeachersBtn) {
        tabTeachersBtn.style.background = "transparent";
        tabTeachersBtn.style.color = "gold";
    }
};

// 1. Bắt sự kiện bấm Tab Quản Lý GV (Chỉ Admin)
if (tabTeachersBtn) {
    tabTeachersBtn.addEventListener('click', () => {
        resetAllAdminTabs();
        tabTeachersBtn.style.background = "gold";
        tabTeachersBtn.style.color = "black";
        if (adminTeacherContent) adminTeacherContent.classList.remove('hidden');
        loadTeacherList(); // Tải danh sách GV
    });
}

// 2. Load danh sách Giáo viên
function loadTeacherList() {
    const tbody = document.getElementById('teacher-list-tbody');
    if (!tbody) return;
    tbody.innerHTML = '<tr><td colspan="4" style="text-align:center;">Đang tải dữ liệu...</td></tr>';

    fetch(`${API_BASE_URL}/teachers`)
        .then(res => res.json())
        .then(teachers => {
            tbody.innerHTML = '';
            teachers.forEach(t => {
                const isAdmin = t.username === 'admin';
                const actionButtons = isAdmin ?
                    `<span style="color:gray;">Tài khoản gốc</span>` :
                    `<button onclick="openAdminEditTeacher('${t.id}', '${t.username}', '${t.full_name}')" style="background: gold; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer; margin-right: 5px;">✏️ Sửa</button>
<button type="button" onclick="adminDeleteTeacher('${t.id}')" style="background: #d71515; color: white; border: none; padding: 5px 10px; border-radius: 3px; cursor: pointer;">🗑️ Xóa</button> `;
                tbody.innerHTML += `
                    <tr style="border-bottom: 1px solid #001a57;">
                        <td style="padding: 10px; text-align:center;">${t.id}</td>
                        <td style="padding: 10px;">${t.username}</td>
                        <td style="padding: 10px;">${t.full_name}</td>
                        <td style="padding: 10px; text-align: center;">${actionButtons}</td>
                    </tr>
                `;
            });
        })
        .catch(err => console.error("Lỗi tải danh sách GV:", err));
}

// 3. Admin Xóa GV
window.adminDeleteTeacher = function (id) {
    showSystemConfirm("Bạn có chắc chắn muốn xóa tài khoản Giáo viên này không?", () => {
        fetch(`${API_BASE_URL}/teachers/${id}`, { method: 'DELETE' })
            .then(res => res.json())
            .then(data => {
                alert("✅ " + data.message);
                loadTeacherList();
            })
            .catch(err => alert("❌ Lỗi xóa GV!"));
    });
}

// 4. Admin Mở form Sửa GV
window.openAdminEditTeacher = function (id, username, fullname) {
    document.getElementById('admin-edit-teacher-id').value = id;
    document.getElementById('admin-edit-teacher-username').value = username;
    document.getElementById('admin-edit-teacher-fullname').value = fullname;
    document.getElementById('admin-edit-teacher-password').value = ""; // Luôn để trống
    document.getElementById('edit-teacher-modal').style.display = 'flex';
}

const closeEditTeacherModal = document.getElementById('close-edit-teacher-modal');
if (closeEditTeacherModal) {
    closeEditTeacherModal.onclick = () => {
        document.getElementById('edit-teacher-modal').style.display = 'none';
    };
}

const editTeacherForm = document.getElementById('edit-teacher-form');
if (editTeacherForm) {
    editTeacherForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const id = document.getElementById('admin-edit-teacher-id').value;
        const username = document.getElementById('admin-edit-teacher-username').value;
        const full_name = document.getElementById('admin-edit-teacher-fullname').value;
        const password = document.getElementById('admin-edit-teacher-password').value;

        fetch(`${API_BASE_URL}/teachers/admin-edit/${id}`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username, full_name, password })
        })
            .then(res => res.json())
            .then(data => {
                alert("✅ " + data.message);
                document.getElementById('edit-teacher-modal').style.display = 'none';
                loadTeacherList();
            })
            .catch(err => alert("❌ Lỗi cập nhật!"));
    });
}

// 5. Nút Admin Cấp tài khoản mới
if (createTeacherBtn) {
    createTeacherBtn.addEventListener('click', () => {
        const username = document.getElementById('new-teacher-username').value.trim();
        const fullname = document.getElementById('new-teacher-fullname').value.trim();
        const password = document.getElementById('new-teacher-password').value.trim();

        if (!username || !fullname || !password) {
            return alert("⚠️ Vui lòng điền đầy đủ thông tin!");
        }

        fetch(`${API_BASE_URL}/teachers`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ username: username, full_name: fullname, password: password })
        })
            .then(res => res.json())
            .then(data => {
                if (data.message.includes('Lỗi') || data.message.includes('tồn tại')) {
                    alert("❌ " + data.message);
                } else {
                    alert("✅ " + data.message);
                    document.getElementById('new-teacher-username').value = "";
                    document.getElementById('new-teacher-fullname').value = "";
                    document.getElementById('new-teacher-password').value = "";
                    loadTeacherList(); // Tải lại bảng ngay lập tức
                }
            })
            .catch(err => alert("❌ Lỗi kết nối Server!"));
    });
}

// 6. GIÁO VIÊN TỰ QUẢN LÝ HỒ SƠ
if (teacherProfileBtn) {
    teacherProfileBtn.addEventListener('click', () => {
        if (!currentTeacher) return;
        document.getElementById('profile-username').value = currentTeacher.username;
        document.getElementById('profile-fullname').value = currentTeacher.full_name;
        document.getElementById('profile-old-pass').value = '';
        document.getElementById('profile-new-pass').value = '';

        document.getElementById('teacher-profile-modal').style.display = 'flex';
    });
}

const closeTeacherProfileModal = document.getElementById('close-teacher-profile-modal');
if (closeTeacherProfileModal) {
    closeTeacherProfileModal.onclick = () => {
        document.getElementById('teacher-profile-modal').style.display = 'none';
    };
}

const teacherUpdateProfileForm = document.getElementById('teacher-update-profile-form');
if (teacherUpdateProfileForm) {
    teacherUpdateProfileForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const username = document.getElementById('profile-username').value;
        const full_name = document.getElementById('profile-fullname').value;

        fetch(`${API_BASE_URL}/teacher-update-profile`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ teacher_id: currentTeacher.id, username, full_name })
        })
            .then(res => res.json())
            .then(data => {
                if (data.message.includes('thành công')) {
                    alert("✅ " + data.message);
                    currentTeacher.username = username;
                    currentTeacher.full_name = full_name;
                } else {
                    alert("⚠️ " + data.message);
                }
            })
            .catch(err => alert("❌ Lỗi kết nối!"));
    });
}

const teacherChangePasswordForm = document.getElementById('teacher-change-password-form');
if (teacherChangePasswordForm) {
    teacherChangePasswordForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const old_password = document.getElementById('profile-old-pass').value;
        const new_password = document.getElementById('profile-new-pass').value;

        fetch(`${API_BASE_URL}/teacher-change-password`, {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ teacher_id: currentTeacher.id, old_password, new_password })
        })
            .then(res => {
                if (!res.ok) throw res;
                return res.json();
            })
            .then(data => {
                alert("✅ " + data.message);
                document.getElementById('profile-old-pass').value = '';
                document.getElementById('profile-new-pass').value = '';
            })
            .catch(async err => {
                const errorData = await err.json();
                alert("⚠️ " + errorData.message);
            });
    });
}


window.submitEditTeacher = function () {
    const id = document.getElementById('admin-edit-teacher-id').value;
    const username = document.getElementById('admin-edit-teacher-username').value;
    const full_name = document.getElementById('admin-edit-teacher-fullname').value;
    const password = document.getElementById('admin-edit-teacher-password').value;

    fetch(`${API_BASE_URL}/teachers/admin-edit/${id}`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ username, full_name, password })
    })
        .then(res => res.json())
        .then(data => {
            alert("✅ " + data.message);
            document.getElementById('edit-teacher-modal').style.display = 'none';
            loadTeacherList(); // Tải lại bảng ngay lập tức
        })
        .catch(err => alert("❌ Lỗi cập nhật!"));
};

window.submitUpdateProfile = function () {
    const username = document.getElementById('profile-username').value;
    const full_name = document.getElementById('profile-fullname').value;

    fetch(`${API_BASE_URL}/teacher-update-profile`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ teacher_id: currentTeacher.id, username, full_name })
    })
        .then(res => res.json())
        .then(data => {
            if (data.message.includes('thành công')) {
                alert("✅ " + data.message);
                // Cập nhật lại thông tin ở Local
                currentTeacher.username = username;
                currentTeacher.full_name = full_name;
            } else {
                alert("⚠️ " + data.message);
            }
        })
        .catch(err => alert("❌ Lỗi kết nối!"));
};

window.submitChangePassword = function () {
    const old_password = document.getElementById('profile-old-pass').value;
    const new_password = document.getElementById('profile-new-pass').value;

    if (!old_password || !new_password) {
        return alert("⚠️ Vui lòng nhập đầy đủ mật khẩu!");
    }

    fetch(`${API_BASE_URL}/teacher-change-password`, {
        method: 'PUT',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ teacher_id: currentTeacher.id, old_password, new_password })
    })
        .then(res => {
            if (!res.ok) throw res;
            return res.json();
        })
        .then(data => {
            alert("✅ " + data.message);
            // Xóa trắng ô nhập sau khi đổi thành công
            document.getElementById('profile-old-pass').value = '';
            document.getElementById('profile-new-pass').value = '';
        })
        .catch(async err => {
            const errorData = await err.json();
            alert("⚠️ " + errorData.message);
        });
};


window.showSystemConfirm = function (message, onConfirm) {
    const modal = document.getElementById('system-confirm-modal');
    const text = document.getElementById('system-confirm-text');
    const btnConfirm = document.getElementById('btn-sys-confirm');
    const btnCancel = document.getElementById('btn-sys-cancel');

    if (!modal) return alert(message); // Đề phòng lỗi nếu không tìm thấy HTML

    text.innerText = message;
    modal.style.display = 'flex';

    btnConfirm.onclick = () => {
        modal.style.display = 'none';
        onConfirm();
    };

    btnCancel.onclick = () => {
        modal.style.display = 'none';
    };
};